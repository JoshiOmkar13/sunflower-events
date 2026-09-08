# SUNFLOWER EVENTS LLP — Hostinger VPS Remote Deployment Automation
# Target Host: 72.62.198.241 (Production Cloud VPS)

param(
    [string]$HostName = "72.62.198.241",
    [string]$PublicHost = "sunflower-events.bjttvo.easypanel.host",
    [string]$IdentityFile = "$env:USERPROFILE\.ssh\dg_online_hostinger",
    [int]$DirectPort = 3086
)

$ErrorActionPreference = "Stop"
$projectRoot = Join-Path (Resolve-Path (Join-Path $PSScriptRoot "..")).Path "presentation"

Write-Host "`n=================================================================" -ForegroundColor Cyan
Write-Host "  🌻 SUNFLOWER EVENTS LLP -- HOSTINGER VPS DEPLOYMENT PIPELINE" -ForegroundColor Yellow
Write-Host "  Target VPS: root@$HostName (Port: $DirectPort | Domain: https://$PublicHost)" -ForegroundColor Cyan
Write-Host "=================================================================`n" -ForegroundColor Cyan

# 1. Create Release Archive
$release = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
$archive = Join-Path $env:TEMP "sunflower-events-$release.tar.gz"

Write-Host "[1/4] Creating Clean Release Archive ($release)..." -ForegroundColor Cyan
Push-Location $projectRoot
try {
    tar --exclude=.git -czf $archive .
} finally {
    Pop-Location
}
Write-Host "  [OK] Release archive created: $archive" -ForegroundColor Green

# 2. Check Authentication Strategy (SSH Key vs Password)
$useKey = Test-Path -LiteralPath $IdentityFile

if ($useKey) {
    Write-Host "[2/4] Authenticating via SSH Key ($IdentityFile)..." -ForegroundColor Cyan
    $sshOpts = @("-o", "StrictHostKeyChecking=accept-new", "-i", $IdentityFile)
    $scpOpts = @("-o", "StrictHostKeyChecking=accept-new", "-i", $IdentityFile)

    Write-Host "`n[3/4] Uploading Release Archive & Deploying to Hostinger VPS..." -ForegroundColor Cyan
    & scp @scpOpts $archive "root@${HostName}:/tmp/sunflower-events-$release.tar.gz"

    $remoteScript = @"
set -eu
mkdir -p /opt/sunflower-events/releases/$release
tar -xzf /tmp/sunflower-events-$release.tar.gz -C /opt/sunflower-events/releases/$release
rm -f /tmp/sunflower-events-$release.tar.gz
cd /opt/sunflower-events/releases/$release

# Build container image
docker build -t sunflower-events:$release -t sunflower-events:latest .

# Deploy or update Docker Swarm service
if docker service inspect sunflower-events >/dev/null 2>&1; then
    docker service update \
      --image sunflower-events:$release \
      --publish-add published=$DirectPort,target=80 \
      --update-order start-first \
      sunflower-events
else
    docker service create \
      --name sunflower-events \
      --network easypanel \
      --replicas 1 \
      --publish published=$DirectPort,target=80 \
      --restart-condition any \
      --update-order start-first \
      --limit-memory 256M \
      --reserve-memory 32M \
      sunflower-events:$release
fi

# Configure Traefik Ingress Route with Automatic TLS
mkdir -p /etc/easypanel/traefik/config
cat > /etc/easypanel/traefik/config/sunflower-events.yaml <<'ROUTE'
http:
  routers:
    sunflower-events-http:
      rule: Host(`__PUBLIC_HOST__`)
      entryPoints: [http]
      middlewares: [redirect-to-https]
      service: sunflower-events
    sunflower-events-https:
      rule: Host(`__PUBLIC_HOST__`)
      entryPoints: [https]
      service: sunflower-events
      tls:
        certResolver: letsencrypt
  services:
    sunflower-events:
      loadBalancer:
        servers:
          - url: http://sunflower-events:80
ROUTE

echo "Waiting for service to stabilize..."
sleep 4
docker service ps sunflower-events --format 'table {{.Name}}\t{{.CurrentState}}\t{{.Error}}'
"@

    $routeHost = '`' + $PublicHost + '`'
    $remoteScript = $remoteScript.Replace('__PUBLIC_HOST__', $routeHost)

    & ssh @sshOpts "root@$HostName" $remoteScript

    # Verify Health Endpoint
    Write-Host "`n[4/4] Auditing Production Health Endpoint on VPS..." -ForegroundColor Cyan
    $probeCmd = "curl -s -o /dev/null -w '%{http_code}' http://localhost:$DirectPort/ || echo 'WAIT'"
    $httpStatus = & ssh @sshOpts "root@$HostName" $probeCmd
    Write-Host "  HTTP Status Response on Port ${DirectPort}: $httpStatus" -ForegroundColor Green

    Write-Host "`n=================================================================" -ForegroundColor Cyan
    Write-Host "  🎉 DEPLOYMENT COMPLETE: Sunflower Events Presentation is Live!" -ForegroundColor Green
    Write-Host "=================================================================" -ForegroundColor Cyan
    Write-Host "  Public Domain (SSL): https://$PublicHost" -ForegroundColor Green
    Write-Host "  Presentation Deck:   https://$PublicHost/deck.html" -ForegroundColor Green
    Write-Host "  Client Website:      https://$PublicHost/index.html" -ForegroundColor Green
    Write-Host "  Direct VPS URL:      http://${HostName}:${DirectPort}/" -ForegroundColor White
    Write-Host "=================================================================`n" -ForegroundColor Cyan

    Remove-Item -LiteralPath $archive -Force -ErrorAction SilentlyContinue
} else {
    throw "SSH identity key not found at $IdentityFile. Deployment requires SSH key."
}
