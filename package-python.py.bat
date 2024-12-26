@classmethod # 2>nul & (if not exist "%~dp0\expanded\tools\python.exe" (echo Fatal expanded\tools\python.exe not found & pause) else (title %~f0 & "%~dp0\expanded\tools\python.exe" "%~f0" %*)) || pause & exit /B & # noqa: E501
def __unused(): "fake function to help writing header that allows executing same file as python and batch"

import sys, pathlib, shutil, zipfile

def create_python_distr(full_dir: pathlib.Path, target_dir: pathlib.Path):
    if target_dir.exists():
        shutil.rmtree(target_dir)
    shutil.copytree(full_dir/"DLLs", target_dir/"DLLs")
    for f in full_dir.iterdir():
        if f.suffix.lower() in {".exe", ".dll"}:
            shutil.copy2(f, target_dir)
    expected_zip_name = pathlib.Path(next(p for p in sys.path if p.endswith(".zip"))).name
    std_lib = zipfile.PyZipFile(target_dir / expected_zip_name, mode="w")
    source_lib = full_dir/"Lib"
    std_lib.writepy(source_lib)
    for package in source_lib.iterdir():
        if package.is_dir():
            std_lib.writepy(package)

if __name__ == "__main__":
    full_dir = pathlib.Path(sys.executable).absolute().parent
    target_dir = pathlib.Path(__file__).absolute().parent / "artifacts"
    create_python_distr(full_dir, target_dir)