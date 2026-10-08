param([string]$target)
# Ab Encoding line param ke baad aayegi
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if ($target -eq "linux") {
    $env:GOOS = "linux"
    $env:GOARCH = "amd64"
    $env:CGO_ENABLED = "0"
    Write-Host "Building for LINUX..." -ForegroundColor Cyan
    go-winres make .
    go build -ldflags="-s -w" -o ttwa .
}
elseif ($target -eq "mac") {
    $env:GOOS = "darwin"
    $env:GOARCH = "amd64"
    $env:CGO_ENABLED = "0"
    Write-Host "Building for MAC (Intel)..." -ForegroundColor Magenta
    go build -ldflags="-s -w" -o ttwa-mac-intel .
}
elseif ($target -eq "mac-arm") {
    $env:GOOS = "darwin"
    $env:GOARCH = "arm64"
    $env:CGO_ENABLED = "0"
    Write-Host "Building for MAC (Apple Silicon M1/M2/M3)..." -ForegroundColor Magenta
    go build -ldflags="-s -w" -o ttwa-mac-arm64 .
}
elseif ($target -eq "mac-all") {
    # Dono arch build kar
    $env:GOOS = "darwin"
    $env:CGO_ENABLED = "0"
    
    $env:GOARCH = "amd64"
    Write-Host "Building for MAC Intel..." -ForegroundColor Magenta
    go build -ldflags="-s -w" -o ttwa-mac-intel .
    
    $env:GOARCH = "arm64"
    Write-Host "Building for MAC Apple Silicon..." -ForegroundColor Magenta
    go build -ldflags="-s -w" -o ttwa-mac-arm64 .
    
    Write-Host "Dono binaries ban gayi. Universal banane ke liye Mac pe lipo chala:" -ForegroundColor Yellow
    Write-Host "  lipo -create -output ttwa ttwa-mac-intel ttwa-mac-arm64" -ForegroundColor Yellow
}
else {
    $env:GOOS = "windows"
    $env:GOARCH = "amd64"
    $env:CGO_ENABLED = "0"
    Write-Host "Building for WINDOWS..." -ForegroundColor Yellow
    go-winres make .
    go build -ldflags="-H=windowsgui -s -w" -o ttwa.exe .
}

# --- RESET SECTION ---
# Build khatam hone ke baad wapis Windows mode mein set kar dete hain
$env:GOOS = "windows"
$env:GOARCH = "amd64"
$env:CGO_ENABLED = "0" # Ya "1" agar tu windows par CGO use karta hai

Write-Host "Build Done & Environment Reset to Windows!" -ForegroundColor Green
