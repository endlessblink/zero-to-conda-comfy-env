


![zero to conda comfy env cover](./zero-to-conda-comfy-env-cover.png)


# Zero to Conda ComfyUI Environment

A Windows batch script that takes you from zero to a fully configured ComfyUI environment with Conda. No manual setup required!

## Prerequisites

- Windows operating system
- [Git](https://git-scm.com/downloads) installed and available in PATH
- [Miniconda](https://docs.conda.io/en/latest/miniconda.html) or [Anaconda](https://www.anaconda.com/download) installed

## Features

- Creates a new Conda environment
- Clones the ComfyUI repository
- Installs PyTorch with CUDA support
- Installs all required dependencies
- Creates a convenient run script

## Usage

1. Download the setup script
2. Edit the `CONDA_PATH` variable in the script if your Conda installation is not in the default location
3. Run the script
4. Enter a name for your new Conda environment when prompted
5. Enter the installation path for ComfyUI when prompted
6. Wait for the installation to complete

## What the Script Does

1. Checks for required prerequisites (Git, Conda)
2. Creates a new Conda environment with Python 3.10
3. Clones the ComfyUI repository
4. Installs PyTorch with CUDA support
5. Installs ComfyUI requirements
6. Installs additional dependencies (insightface, onnxruntime-gpu)
7. Creates a run script for easy launching

## Troubleshooting

If you encounter any issues:

1. Ensure all prerequisites are properly installed
2. Check that the `CONDA_PATH` in the script matches your Conda installation
3. Run the script as administrator if you encounter permission issues
4. Check your internet connection if downloads fail

## License

This script is released under the MIT License. See the LICENSE file for details. 





