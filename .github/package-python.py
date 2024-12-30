import sys, pathlib, shutil, zipfile, subprocess
SELF_DIR = pathlib.Path(__file__).absolute().parent

def create_python_distr(full_dir: pathlib.Path, target_dir: pathlib.Path):
    if target_dir.exists():
        shutil.rmtree(target_dir)
    shutil.copytree(full_dir/"DLLs", target_dir/"DLLs")
    for f in full_dir.iterdir():
        if f.suffix.lower() in {".exe", ".dll"}:
            shutil.copy2(f, target_dir)
    expected_zip_name = pathlib.Path(next(p for p in sys.path if p.endswith(".zip"))).name
    with zipfile.PyZipFile(target_dir / expected_zip_name, mode="w") as std_lib:
        source_lib = full_dir/"Lib"
        std_lib.writepy(source_lib)
        target_site = target_dir/"Lib/site-packages"
        target_site.mkdir(parents=True)

        for package in source_lib.iterdir():
            if package.is_dir():
                if package.name in {"venv", "pydoc_data", "ensurepip", "idlelib", "turtledemo"}:
                    # packages with non-py files that a simpler to handle out-of-zip
                    shutil.copytree(package, target_dir/"Lib"/package.name)
                else:
                    std_lib.writepy(package)
        shutil.rmtree(target_dir/"Lib/idlelib/idle_test")

    for sub_dir in ("tcl8.6", "tk8.6"):
        sub_target = target_dir / "tcl" / sub_dir
        sub_target.mkdir(parents=True)
        for f in (full_dir/ "tcl" / sub_dir).iterdir():
            if f.suffix.lower() == ".tcl" or f.name.lower() in {"tclindex", "opt0.4", "ttk"}:
                if f.is_dir():
                    shutil.copytree(f, sub_target / f.name)
                else:
                    shutil.copy2(f, sub_target / f.name)
        
    shutil.copy2(SELF_DIR / "ConsoleForPortablePip.bat", target_dir)
    shutil.copy2(SELF_DIR / "portable-pip.bat", target_dir / "pip.bat")
    shutil.copy2(SELF_DIR / "portable-pip.bat", target_dir / "pip3.bat")

if __name__ == "__main__":
    full_dir = pathlib.Path(sys.executable).absolute().parent
    target_dir = SELF_DIR.parent / "artifacts"
    create_python_distr(full_dir, target_dir)