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
$env:CGO_ENABLED = "0" # Ya "1" agar tu windows par CGO use karta hai

Write-Host "Build Done & Environment Reset to Windows!" -ForegroundColor Green
