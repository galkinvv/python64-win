@PATH %~dp0;%PATH%
@PROMPT %~n0 %PROMPT%
@FOR %%w IN ("%~dp0\Lib\ensurepip\_bundled\*.whl") DO @SET PYTHONPATH=%%w
@start "%~n0 from %~dp0" cmd /k "<nul set /p=Type ^"python^" to start interpreter or add packages via:   pip install package_name"