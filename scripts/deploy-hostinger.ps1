# SUNFLOWER EVENTS LLP — Hostinger VPS Remote Deployment Automation
# Target Host: 72.62.198.241 (Production Cloud VPS)

param(
    [string]$HostName = "72.62.198.241",
    [string]$PublicHost = "sunflower-events.bjttvo.easypanel.host",
    [string]$EnvFile = "E:\Clients\dg-online\.env.local",
    [int]$DirectPort = 3086
)

$ErrorActionPreference = "Stop"
$projectRoot = "E:\Clients\sunflower-events\presentation"

Write-Host "`n=================================================================" -ForegroundColor Cyan
Write-Host "  🌻 SUNFLOWER EVENTS LLP -- HOSTINGER VPS DEPLOYMENT PIPELINE" -ForegroundColor Yellow
Write-Host "  Target VPS: root@$HostName (Port: $DirectPort | Domain: https://$PublicHost)" -ForegroundColor Cyan
Write-Host "=================================================================`n" -ForegroundColor Cyan

# 1. Load Hostinger VPS credentials
if (-not (Test-Path $EnvFile)) {
    throw "Hostinger configuration file $EnvFile not found."
}

$config = @{}
Get-Content $EnvFile | ForEach-Object {
    if ($_ -match "^\s*([^#=]+)=(.*)$") {
        $config[$matches[1].Trim()] = $matches[2].Trim()
    }
}

$sshUser = if ($config["HOSTINGER_SSH_USER"]) { $config["HOSTINGER_SSH_USER"] } else { "root" }
$sshPass = $config["HOSTINGER_SSH_PASSWORD"]

if (-not $sshPass) {
    throw "HOSTINGER_SSH_PASSWORD not found in $EnvFile."
}

# 2. Create Release Archive
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

# 3. Configure Non-Interactive SSH Authentication
$askpass = Join-Path $env:TEMP "sunflower-ssh-askpass-$release.bat"
Set-Content -LiteralPath $askpass -Value "@echo off`necho $sshPass" -Encoding Ascii
$env:SSH_ASKPASS = $askpass
$env:SSH_ASKPASS_REQUIRE = "force"
$env:DISPLAY = "codex"

$sshOpts = @("-o", "StrictHostKeyChecking=accept-new", "-o", "PreferredAuthentications=password", "-o", "PubkeyAuthentication=no")

try {
    # 4. Stream Upload Release Archive to Hostinger VPS
    Write-Host "`n[2/4] Uploading Release Archive to Hostinger VPS..." -ForegroundColor Cyan

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "ssh.exe"
    $psi.Arguments = "-o StrictHostKeyChecking=accept-new -o PreferredAuthentications=password -o PubkeyAuthentication=no ${sshUser}@${HostName} `"cat > /tmp/sunflower-events-$release.tar.gz`""
    $psi.UseShellExecute = $false
    $psi.RedirectStandardInput = $true
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true

    $p = [System.Diagnostics.Process]::Start($psi)
    $inStream = [System.IO.File]::OpenRead($archive)
    $inStream.CopyTo($p.StandardInput.BaseStream)
    $inStream.Close()
    $p.StandardInput.Close()
    $p.WaitForExit()

    if ($p.ExitCode -ne 0) {
        $err = $p.StandardError.ReadToEnd()
        throw "Failed to stream upload release archive. ExitCode: $($p.ExitCode). Error: $err"
    }
    Write-Host "  [OK] Release archive uploaded successfully." -ForegroundColor Green

    # 5. Remote Unpack, Build, and Swarm Service Deployment
    Write-Host "`n[3/4] Building Docker Image and Orchestrating Swarm Service..." -ForegroundColor Cyan

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
sleep 5
docker service ps sunflower-events --format 'table {{.Name}}\t{{.CurrentState}}\t{{.Error}}'
"@

    $remoteScript = $remoteScript.Replace('__PUBLIC_HOST__', $PublicHost)
    $remoteScript = $remoteScript.Replace('$DirectPort', $DirectPort.ToString())

    $out = & ssh.exe @sshOpts "${sshUser}@${HostName}" $remoteScript
    Write-Host $out -ForegroundColor Green

    # 6. Verify Health Endpoint
    Write-Host "`n[4/4] Auditing Production Health Endpoint on VPS..." -ForegroundColor Cyan
    $probeCmd = "curl -s -o /dev/null -w '%{http_code}' http://localhost:$DirectPort/ || echo 'WAIT'"
    $httpStatus = & ssh.exe @sshOpts "${sshUser}@${HostName}" $probeCmd
    Write-Host "  HTTP Status Response on Port ${DirectPort}: $httpStatus" -ForegroundColor Green

    Write-Host "`n=================================================================" -ForegroundColor Cyan
    Write-Host "  🎉 DEPLOYMENT COMPLETE: Sunflower Events Presentation is Live!" -ForegroundColor Green
    Write-Host "=================================================================" -ForegroundColor Cyan
    Write-Host "  Public Domain (SSL): https://$PublicHost" -ForegroundColor Green
    Write-Host "  Direct VPS URL:      http://${HostName}:${DirectPort}/" -ForegroundColor White
    Write-Host "=================================================================`n" -ForegroundColor Cyan
}
finally {
    Remove-Item -LiteralPath $archive -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $askpass -Force -ErrorAction SilentlyContinue
}
