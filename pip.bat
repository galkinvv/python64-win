:: presence of following "|| call call" supresses "Terminate batch job" question on Ctrl+C
@"%~dp0\python" -m _pip_in_zip %~n0.bat %* || CALL CALL
@IF /I "%COMSPEC% /c %~f0 " EQU "%cmdcmdline:"=%" (
    :: script name with a trailing space present at the end of cmdcmdline - so script was executed by double click in explorer
    ECHO.
    powershell Write-Host -NoNewline -Back Red NOTE!
    ECHO  %~nx0 is NOT intended to be run from GUI
    ECHO       Use ConsolePIPinZIP.bat to get terminal and enter command like below:
    ECHO       pip install package_name
    PAUSE
)