#!/bin/bash
set -euo pipefail


# Export all variables needed by run_install.sh
export VERSION="2025.01"
export CONDA_ENV_NAME="rl9_cudnn9_cuda12.9_py3.12"
export PREFIX="$PWD"
export SOFTWARE_SOURCE_DIRECTORY="/sw/sources"
export MODULESHOME="/sw/rl9g/modulefiles/applications/machine_learning"
export PACKAGE="machine_learning"
export SRCDIR="${SOFTWARE_SOURCE_DIRECTORY}/${PACKAGE}"
export SRC_REPO="https://github.com/D-Barradas/ibex-machine-learning-modules.git"
export TARGET_DIR="machine_learning/${VERSION}/${CONDA_ENV_NAME}_env"

# Create the target directory
mkdir -p "$TARGET_DIR"

# Change permissions on the specified directory
chmod g+w "$TARGET_DIR"

# Copy run_install.sh into the new directory
cp run_install.sh "$TARGET_DIR/"

# Change to the new directory and execute the script
cd "$TARGET_DIR"
bash run_install.sh

# Create a module file
bash generate_modulefile.sh