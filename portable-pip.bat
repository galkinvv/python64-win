@PATH %~dp0;%PATH%
@FOR %%w IN ("%~dp0\Lib\ensurepip\_bundled\*.whl") DO @SET PYTHONPATH=%%w;%PYTHONPATH%
@"%~dp0\python" -c "import sys,sysconfig,os.path,os,runpy; sys.argv[0]=r'%~n0'"^

"os.chdir(os.path.dirname(sys.executable)); sys.executable=r'.\python.exe'  # alters the python name embedded in installed launchers"^

"sysconfig._INSTALL_SCHEMES['nt']['scripts'] = '{base}'  # alters the launchers directory"^

"runpy.run_module('pip', run_name='__main__')" %*