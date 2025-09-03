#!/bin/bash
set -euo pipefail


# Check for required commands
command -v git >/dev/null 2>&1 || { echo "git is required but not installed. Aborting."; exit 1; }

############################## standard interface to installation
# Input:
#############################   Environment variables
# The following variables should be set by the parent script or environment:
#   PREFIX, SOFTWARE_SOURCE_DIRECTORY, PACKAGE, VERSION, SRCDIR, SRC_REPO
#                     only to be used in special circumstances
# Output
#   Return code of 0=success or 1=failure
############################## MODULES LOADED
#MODULES LOADED
############################## INSTALLATION

INSTALL_BUILD_PATH="${PREFIX}/machine_learning-module"

# Clone the repository branch corresponding to the version
if ! git clone "${SRC_REPO}" -b "machine-learning-${VERSION}" "${INSTALL_BUILD_PATH}" | tee -a install.log; then
  echo "$PACKAGE - repository clone failure - installation failed"
  exit 1
fi

cd "${INSTALL_BUILD_PATH}"
if ! "${INSTALL_BUILD_PATH}/bin/create-conda-env.sh" | tee -a install.log; then
  echo "$PACKAGE - build failure - installation failed"
  exit 1
fi

############################### if this far, return 0
exit 0