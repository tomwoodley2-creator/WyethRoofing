# Screenshot helper using installed Chrome headless.
# Usage: powershell -File screenshot.ps1 http://localhost:3000 [label] [-Width 1440] [-Height 3200]
param(
  [string]$Url = "http://localhost:3000",
  [string]$Label = "",
  [int]$Width = 1440,
  [int]$Height = 3200
)

$chrome = @(
  "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
  "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
  "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $chrome) { Write-Error "Chrome not found"; exit 1 }

$outDir = Join-Path $PSScriptRoot "temporary screenshots"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$n = 1
Get-ChildItem $outDir -Filter "screenshot-*.png" -ErrorAction SilentlyContinue | ForEach-Object {
  if ($_.Name -match "screenshot-(\d+)") { $v = [int]$Matches[1]; if ($v -ge $n) { $n = $v + 1 } }
}
$name = if ($Label) { "screenshot-$n-$Label.png" } else { "screenshot-$n.png" }
$out = Join-Path $outDir $name

$profile = Join-Path $env:TEMP ("chrome-shot-" + [guid]::NewGuid().ToString("N"))
& $chrome --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 `
  --user-data-dir="$profile" --window-size="$Width,$Height" `
  --virtual-time-budget=6000 --screenshot="$out" "$Url" 2>$null | Out-Null

Start-Sleep -Milliseconds 300
Remove-Item -Recurse -Force $profile -ErrorAction SilentlyContinue

if (Test-Path $out) { Write-Host "Saved $out" } else { Write-Error "Screenshot failed" }
