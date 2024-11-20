param (
    [Parameter(Mandatory=$true)][string]$pythonver
)
(Get-Location).Path | Out-String -Stream
New-Item -Type Directory -Force ./downloaded
if (!(Test-Path "./downloaded/python.${pythonver}.nupkg.zip")) {
    Invoke-WebRequest -Uri "https://github.com/adang1345/PythonWin7/raw/refs/heads/master/${pythonver}/python.${pythonver}.nupkg" -OutFile "./downloaded/python.${pythonver}.nupkg.zip"
}
Expand-Archive -LiteralPath "./downloaded/python.${pythonver}.nupkg.zip"
Rename-Item "python.${pythonver}.nupkg" -NewName "expanded"
Get-ChildItem "expanded"
