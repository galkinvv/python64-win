@classmethod # 2>nul & (if not exist "%~dp0\..\python.exe" (echo Fatal ..\python.exe not found & pause) else (title %~f0 & "%~dp0\..\python.exe" "%~f0" %*)) & exit /B & # noqa: E501
def __unused(): "fake function to help writing header that allows executing same file as python and batch"
    
import re
import sys
from pip._internal.cli.main import main
sys.argv[0] = "pip"
sys.exit(main())
