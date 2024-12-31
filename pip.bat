@"%~dp0\python" -m _pip_in_zip %~n0.bat %*
:: Check if script was executed by double clock in explorer - search for script name near the end of cmdcmdline
@ECHO %cmdcmdline%| findstr /I /R %~n0.bat...$ >NUL
@IF %ERRORLEVEL%==0 (
    ECHO. 
    ECHO. 
    ECHO Note: %~n0.bat is NOT intended to be run from GUI
    ECHO       Use ConsolePIPinZIP.bat to get terminal and enter command like below:
    ECHO       pip install package_name
    ECHO.
    ECHO       Press any key to continue...
    PAUSE >NUL
)