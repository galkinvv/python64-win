@PATH %~dp0;%PATH%
@PROMPT %~n0 %PROMPT%
@START "%~n0 from %~dp0" CMD /k "<NUL SET /P= Type ^"python^" to start interpreter or add packages via:   pip install package_name"