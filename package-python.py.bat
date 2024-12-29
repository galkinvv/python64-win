@classmethod # 2>nul & (if not exist "%~dp0\expanded\tools\python.exe" (echo Fatal expanded\tools\python.exe not found & pause) else (title %~f0 & "%~dp0\expanded\tools\python.exe" "%~f0" %*)) || pause & exit /B & # noqa: E501
def __unused(): "fake function to help writing header that allows executing same file as python and batch"

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
                if package.name in {"venv", "pydoc_data", "ensurepip"}:
                    # packages with non-py files that a simpler to handle out-of-zip
                    shutil.copytree(package, target_dir/"Lib"/package.name)
                else:
                    std_lib.writepy(package)
    bundled_pip_name = next((target_dir/"Lib/ensurepip/_bundled").iterdir()).relative_to(target_dir)
    pth_text = (SELF_DIR / "python3.pth").read_text()
    (target_dir/"python3.pth").write_text(pth_text + f"\n{bundled_pip_name}")
    # install executables for calling pip from target dir, but since the pip itself is added to pth as bundled archive - delete its installation in site-packages
    subprocess.check_call([str(target_dir/pathlib.Path(sys.executable).name), "-m", "ensurepip", "--default-pip"], cwd=target_dir)
    for package in target_site.iterdir():
        if package.is_dir() and package.name.startswith("pip"):
            shutil.rmtree(package)

if __name__ == "__main__":
    full_dir = pathlib.Path(sys.executable).absolute().parent
    target_dir = SELF_DIR / "artifacts"
    create_python_distr(full_dir, target_dir)
