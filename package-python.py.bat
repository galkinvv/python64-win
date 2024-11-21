@classmethod # 2>nul & (if not exist "%~dp0\expanded\tools\python.exe" (echo Fatal expanded\tools\python.exe not found & pause) else (title %~f0 & "%~dp0\expanded\tools\python.exe" "%~f0" %*)) || pause & exit /B & # noqa: E501
def __unused(): "fake function to help writing header that allows executing same file as python and batch"

import sys, pathlib
print(pathlib.Path(__file__).absolute())
print(sys.version, sys.path)
