# Naprawa PATH dla Claude Code
$bin = Join-Path $env:USERPROFILE ".local\bin"
$exe = Join-Path $bin "claude.exe"

if (-not (Test-Path $exe)) {
  Write-Host "NIE ZNALEZIONO claude.exe w: $bin" -ForegroundColor Red
  Write-Host "Zainstaluj ponownie: irm https://claude.ai/install.ps1 | iex"
  return
}

$u = [Environment]::GetEnvironmentVariable("Path", "User")
$czysty = ($u -split ";" | Where-Object { $_ -and ($_ -notmatch "\.local\bin$") -and ($_ -notmatch "filmb\.local") }) -join ";"
[Environment]::SetEnvironmentVariable("Path", ($czysty.TrimEnd(";") + ";" + $bin), "User")
$env:Path = $env:Path + ";" + $bin

Write-Host ""
Write-Host "PATH poprawiony. Dopisano: $bin" -ForegroundColor Green
& $exe --version
Write-Host ""
Write-Host "Zamknij to okno, otworz nowe i wpisz: claude" -ForegroundColor Yellow
