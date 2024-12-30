param (
    [Parameter(Mandatory=$true)][string]$pythoninstexe,
    [Parameter(Mandatory=$true)][string]$pythoninsturl,
)
New-Item -Type Directory -Force ./downloaded
if (!(Test-Path "./downloaded/${pythoninstexe}")) {
    Invoke-WebRequest -Uri "${pythoninsturl}/${pythoninstexe}" -OutFile "./downloaded/${pythoninstexe}"
}
New-Item -Type Directory -Force ./expanded
#run exe and wauit for its completion
& "downloaded/${pythoninstexe}" /quiet /log  expanded/install-log.txt AssociateFiles=0 Include_doc=0 Include_dev=0 Include_launcher=0 Include_pip=0 Include_test=0 Shortcuts=0 "DefaultJustForMeTargetDir=${PSScriptRoot}\expanded" | Out-Default