@echo off
setlocal enabledelayedexpansion

:: ComfyUI Setup Script
:: This script automates the setup of ComfyUI with a Conda environment
:: 
:: Prerequisites:
::   - Miniconda or Anaconda installed
::   - Git installed
::   - Internet connection
::
:: Usage:
::   1. Run this script
::   2. Enter a name for your Conda environment when prompted
::   3. Enter the installation path for ComfyUI when prompted
::   4. Wait for the installation to complete

:: Check if git is installed
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Git is not installed or not in PATH
    echo Please install Git from https://git-scm.com/downloads
    pause
    exit /b 1
)

set CONDA_PATH=c:/pinokio/bin/miniconda
set CONDA_BAT=%CONDA_PATH%\condabin\conda.bat

if not exist "%CONDA_BAT%" (
    echo Error: Conda not found at %CONDA_BAT%
    echo Please install Miniconda/Anaconda or update the CONDA_PATH in this script.
    pause
    exit /b 1
)

echo Activating Conda...
call "%CONDA_BAT%" activate
if %errorlevel% neq 0 (
    echo Error: Failed to activate Conda
    pause
    exit /b 1
)

:input_env_name
set /p ENV_NAME=Enter the name for your new Conda environment (e.g., comfyui): 
if "%ENV_NAME%"=="" (
    echo Error: Environment name cannot be empty. Please try again.
    goto input_env_name
)

:input_install_path
set /p COMFYUI_PATH=Enter the path where you want to install ComfyUI (e.g., D:\ComfyUI): 
if "%COMFYUI_PATH%"=="" (
    echo Error: Installation path cannot be empty. Please try again.
    goto input_install_path
)

echo Creating new environment %ENV_NAME%...
call "%CONDA_BAT%" create -n %ENV_NAME% python=3.10 -y
if %errorlevel% neq 0 (
    echo Error: Failed to create %ENV_NAME% environment
    pause
    exit /b 1
)

echo Activating %ENV_NAME% environment...
call "%CONDA_BAT%" activate %ENV_NAME%
if %errorlevel% neq 0 (
    echo Error: Failed to activate %ENV_NAME% environment
    pause
    exit /b 1
)

if not exist "%COMFYUI_PATH%\ComfyUI" (
    echo ComfyUI folder not found. Cloning the repository...
    mkdir "%COMFYUI_PATH%" 2>nul
    git clone https://github.com/comfyanonymous/ComfyUI.git "%COMFYUI_PATH%\ComfyUI"
    if %errorlevel% neq 0 (
        echo Error: Failed to clone ComfyUI repository
        echo Please check your internet connection and try again
        pause
        exit /b 1
    )
)

echo Changing directory to ComfyUI folder...
cd /d "%COMFYUI_PATH%\ComfyUI"
if %errorlevel% neq 0 (
    echo Error: Failed to change directory
    echo Current directory is:
    cd
    pause
    exit /b 1
)

echo Installing PyTorch with CUDA support...
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
if %errorlevel% neq 0 (
    echo Warning: PyTorch installation might have failed
    echo You may need to install it manually after the script finishes
)

echo Installing ComfyUI requirements...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo Warning: Some requirements might have failed to install
    echo You may need to install them manually after the script finishes
)

echo Installing additional dependencies (insightface, onnxruntime-gpu)...
pip install insightface onnxruntime-gpu
if %errorlevel% neq 0 (
    echo Warning: Additional dependencies installation might have failed
    echo You may need to install them manually after the script finishes
)

echo Installing Reactor dependencies...
pip install opencv-python pillow tqdm
if %errorlevel% neq 0 (
    echo Warning: Reactor dependencies installation might have failed
    echo You may need to install them manually after the script finishes
)

echo Creating run script for ComfyUI...
(
echo @echo off
echo call "%CONDA_BAT%" activate %ENV_NAME%
echo cd /d "%COMFYUI_PATH%\ComfyUI"
echo python main.py
echo pause
) > "%COMFYUI_PATH%\run_comfyui_%ENV_NAME%.bat"

echo.
echo Setup complete! 
echo A new file 'run_comfyui_%ENV_NAME%.bat' has been created in %COMFYUI_PATH%
echo You can use this file to run ComfyUI with the %ENV_NAME% environment.
echo.

echo Do you want to run ComfyUI now? (Y/N)
set /p RUN_NOW=
if /i "%RUN_NOW%"=="Y" (
    echo Running ComfyUI...
    python main.py
) else (
    echo You can run ComfyUI later using the 'run_comfyui_%ENV_NAME%.bat' file.
)

pause





