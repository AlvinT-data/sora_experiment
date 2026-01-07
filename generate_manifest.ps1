# generate_manifest.ps1

$root = if ($PSScriptRoot -and $PSScriptRoot.Trim().Length -gt 0) {
  $PSScriptRoot
} else {
  (Get-Location).Path
}

$videoDir = Join-Path $root "videos"
$outFile  = Join-Path $root "videos_manifest.json"

if (!(Test-Path $videoDir)) {
  Write-Error "Folder not found: $videoDir"
  exit 1
}

$files = Get-ChildItem -Path $videoDir -File |
  Where-Object { $_.Extension -in ".mp4", ".webm", ".ogg" } |
  Select-Object -ExpandProperty Name |
  Sort-Object

$files | ConvertTo-Json -Compress | Out-File -Encoding utf8 $outFile
Write-Host "Wrote $($files.Count) file(s) to $outFile"
