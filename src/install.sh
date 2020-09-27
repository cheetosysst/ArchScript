#!/bin/sh
# 
# Main script for this install script.

PROJECT_NAME="ArchInstall"
SCRIPT_VERSION="v0.1a"
SCRIPT_GIT_URL="https://github.com/cheetosysst/ArchScript"
ARCH_REPO_URL="archlinux.org"
ARCH_INSTALL_GUIDE_URL="https://wiki.archlinux.org/index.php/installation_guide"
AUTHOR="Thect (Chen Chang)"
LICENSE="MIT"
BASEDIR=$(dirname "$0")

cat $BASEDIR/banner
echo "$SCRIPT_VERSION"
echo "Github: $SCRIPT_GIT_URL"
echo "Author: $AUTHOR"
echo "License: $LICENSE"
echo ""



