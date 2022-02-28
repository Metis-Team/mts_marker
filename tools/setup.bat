;@Findstr -bv ;@F "%~f0" | powershell -Command - & pause & goto:eof

# Unzip backwards compatibility (Windows 8)
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip {
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$client = New-Object Net.WebClient

Write-Output "=> Downloading tools ..."
$client.DownloadFile("http://dev.idi-systems.com/tools/acre2_tools_user.zip", "acre2_tools_user.zip")
$client.dispose()

Write-Output "=> Cleaning old ..."
Remove-Item "..\hemtt.exe" -ErrorAction Ignore
Remove-Item "..\ArmaScriptCompiler.exe" -ErrorAction Ignore

Write-Output "=> Extracting ..."
Unzip "acre2_tools_user.zip" "..\."
Remove-Item "acre2_tools_user.zip"

Remove-Item "..\hemtt" -ErrorAction Ignore

Write-Output "=> Tools successfully installed to project!"
