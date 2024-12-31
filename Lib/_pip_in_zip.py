import ensurepip, os, pathlib, runpy, sys, sysconfig

if __name__ == "__main__":
    # add bundled pip to path with lowest priority
    for whl in (pathlib.Path(ensurepip.__file__).parent.absolute() / "_bundled").glob("*.whl"):
        sys.path.append(str(whl))
    
    exe_dir = os.path.dirname(sys.executable)
    # make pip happy about path and current directory
    os.environ["PATH"] = exe_dir + ";" + os.environ["PATH"]
    os.chdir(exe_dir)
    
    sys.executable = ".\\" + os.path.basename(sys.executable)  # alters the python name embedded in installed launchers
    sysconfig._INSTALL_SCHEMES['nt']['scripts'] = '{base}'  # alters the launchers directory"
    sys.argv.pop(0) # remove this wrapper from command line
    runpy.run_module('pip', run_name='__main__')
