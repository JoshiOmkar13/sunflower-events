# Download authentic gallery images from Sunflower Events Odoo website
$baseUrl = "https://sunflowerevents3.odoo.com"
$destDir = "E:\Clients\sunflower-events\presentation\assets\gallery"

if (-not (Test-Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir | Out-Null
}

$images = [ordered]@{
    "gallery-venue-grand-stage.jpg"     = "/web/image/928-57bd3e8e/IMGL2026.webp"
    "gallery-venue-banquet-hall.jpg"    = "/web/image/933-f3d68a4d/IMG20250501111506.jpg"
    "gallery-venue-floral-mandap.jpg"   = "/web/image/947-9e780b85/IMG-20250519-WA0032%5B1%5D.jpg"
    "gallery-venue-lighting-setup.jpg"  = "/web/image/937-9d12425e/WhatsApp%20Image%202025-04-29%20at%2023.14.26_8cb9d1a0.jpg"
    "gallery-venue-stage-decor.jpg"     = "/web/image/920-b6afe185/WhatsApp%20Image%202025-04-29%20at%2023.03.18_b46b0416.jpg"
    "gallery-venue-banquet-decor.jpg"   = "/web/image/924-35aef865/WhatsApp%20Image%202025-04-29%20at%2023.03.19_ec1152a4.jpg"
    "gallery-venue-grand-hall.jpg"      = "/web/image/942-567549e8/IMG-20250518-WA0016%5B1%5D.webp"
    "gallery-munj-rangoli.jpg"          = "/web/image/905-42afa4e4/Munj%20Rangoli.webp"
    "gallery-custom-name-board.jpg"     = "/web/image/912-9b0341bd/Name%20board%20.jpg"
    "gallery-vratabandha-ceremony.jpg"  = "/web/image/914-b276637e/Vrabandh%20image%201%20for%20PPT.jfif"
    "gallery-floral-entry-umbrella.jpg" = "/web/image/916-b2533ea9/IMG-20260419-WA0028.jpg"
    "gallery-ceremonial-palkhi.jpg"     = "/web/image/918-12eb829f/WhatsApp%20Image%202025-05-15%20at%2009.09.51_074237ac.jpg"
}

foreach ($item in $images.GetEnumerator()) {
    $url = $baseUrl + $item.Value
    $target = Join-Path $destDir $item.Key
    Write-Host "Downloading $($item.Key)..." -ForegroundColor Cyan
    curl.exe -s -L -o $target $url
    $fi = Get-Item $target
    Write-Host "  [OK] Saved: $($fi.Length) bytes" -ForegroundColor Green
}
