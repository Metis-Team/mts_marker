$dir = Join-Path $env:LOCALAPPDATA "Arma 3"
$rpt = Get-ChildItem -Path $dir -Filter *.rpt | Sort-Object LastWriteTime -Descending | Select-Object -First 1

&code --reuse-window $rpt.FullName
