@CD "%~dp0"
@PATH %~dp0;%PATH%
@PROMPT PIPinZIP win64-3.11.11 %PROMPT%
:: prefer pip.bat over pip.exe
@SET PATHEXT=.BAT;%PATHEXT%
@start "PIPinZIP win64-3.11.11 from %~dp0" cmd /k "<nul set /p=Type ^"python^" to start interpreter or add packages by:  pip install package_name"