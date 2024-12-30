@PATH %~dp0;%PATH%
@FOR %%w IN ("%~dp0\Lib\ensurepip\_bundled\*.whl") DO @SET PYTHONPATH=%%w;%PYTHONPATH%
@"%~dp0\python" -c "import sys,sysconfig,os.path,os,runpy; sys.argv[0]=r'%~n0.bat'"^

"os.chdir(os.path.dirname(sys.executable)); sys.executable=r'.\python.exe'  # alters the python name embedded in installed launchers"^

"sysconfig._INSTALL_SCHEMES['nt']['scripts'] = '{base}'  # alters the launchers directory"^

"runpy.run_module('pip', run_name='__main__')" %*
:: Check if script was executed by double clock in explorer - search for script name near the end of cmdcmdline
@ECHO %cmdcmdline%| findstr /I /R %~n0.bat...$ >NUL
@IF %ERRORLEVEL%==0 (
    ECHO. 
    ECHO. 
    ECHO Note: %~n0.bat is not intended to be runed by double clicking
    ECHO       Click ConsolePIPinZIP.bat and enter command like below: 
    ECHO       pip install package_name
    ECHO.
    ECHO       Press any key to continue...
    PAUSE >NUL
)