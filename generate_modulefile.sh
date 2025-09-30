#!/bin/bash
set -euo pipefail

# This script generates a modulefile using variables from setup_install.sh

# Required variables: VERSION, CONDA_ENV_NAME, PREFIX, MODULESHOME, PACKAGE, TARGET_DIR

MODULEFILE_DIR="$MODULESHOME/${VERSION}"
MODULEFILE_PATH="$MODULEFILE_DIR/${CONDA_ENV_NAME}"
PKG_DIR="$PREFIX/$TARGET_DIR/machine_learning-module/env"

mkdir -p "$MODULEFILE_DIR"

cat > "$MODULEFILE_PATH" <<EOF
#%Module 1.0 -*- tcl -*-
#
#  Module for $PACKAGE package:

set name            $PACKAGE
set version         $VERSION
set conda_env_name  $CONDA_ENV_NAME
set pkg_dir         $PKG_DIR

if { [module-info mode load] } {
   puts stderr "Loading module for $PACKAGE $VERSION"
   puts stderr "$PACKAGE $VERSION is now loaded"
   set output [exec python3 /sw/sources/elasticsearch/elasticapps.py --app "$name" --version "$version" &]
}

if { [module-info mode remove] } {
    puts stderr "Unloading module for $PACKAGE $VERSION"
    puts stderr "$PACKAGE $VERSION is now unloaded"
}

prepend-path PATH \$pkg_dir/bin
prepend-path LD_LIBRARY_PATH \$pkg_dir/lib
prepend-path LIBRARY_PATH \$pkg_dir/lib

setenv CONDA_DEFAULT_ENV \$pkg_dir
setenv CONDA_PREFIX \$pkg_dir

prepend-path PYTHONPATH \$pkg_dir/lib
prepend-path PKG_CONFIG_PATH \$pkg_dir/lib/pkgconfig
EOF

echo "Modulefile generated at $MODULEFILE_PATH"
