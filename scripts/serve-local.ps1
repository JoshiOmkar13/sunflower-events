# SUNFLOWER EVENTS LLP — Local Development Server Launcher
param(
    [int]$Port = 8080
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$serverJs = Join-Path $scriptDir "serve-local.js"

$env:PORT = $Port
Write-Host "`n🌻 Starting Sunflower Events Local Server on port $Port..." -ForegroundColor Green
node "$serverJs"
