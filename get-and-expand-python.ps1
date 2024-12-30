param (
    [Parameter(Mandatory=$true)][string]$pythonver
)
(Get-Location).Path | Out-String -Stream
New-Item -Type Directory -Force ./downloaded
if (!(Test-Path "./downloaded/python.${pythonver}.nupkg.zip")) {
    Invoke-WebRequest -Uri "https://github.com/adang1345/PythonWin7/raw/refs/heads/master/${pythonver}/python.${pythonver}.nupkg" -OutFile "./downloaded/python.${pythonver}.nupkg.zip"
}
if (!(Test-Path "./downloaded/python-${pythonver}-amd64-full.exe")) {
    Invoke-WebRequest -Uri "https://github.com/adang1345/PythonWin7/raw/refs/heads/master/${pythonver}/python-${pythonver}-amd64-full.exe" -OutFile "./downloaded/python-${pythonver}-amd64-full.exe"
}
# Expand-Archive -LiteralPath "./downloaded/python.${pythonver}.nupkg.zip"
# Rename-Item "python.${pythonver}.nupkg" -NewName "expanded"
#& "downloaded/python-${pythonver}-amd64-full.exe" /quiet AssociateFiles=0 Include_doc=0 Include_dev=0 Include_launcher=0 Include_pip=0 Include_test=0 Shortcuts=0 DefaultJustForMeTargetDir=expanded | Out-Default
#Get-ChildItem "expanded"
