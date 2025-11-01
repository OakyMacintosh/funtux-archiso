#!/usr/bin/env bash

# SPDX-License-Identifier: GPL-3.0-or-later
# funtuxstrap.sh - Script to bootstrap FunTux

set -euo pipefail
# Load profile variables so we know install_dir and arch
if [ -f "/etc/archiso-profile/profiledef.sh" ]; then
  # shellcheck disable=SC1091
fi

# check if git is installed
if ! command -v git &> /dev/null; then
    echo "git could not be found, please install git before running this script."
    exit 1
fi

# Clone the FunTux repository
if [ ! -d "$install_dir/funtux" ]; then
    git clone https://github.com/oakymacintosh/funtux-userland.git
fi

cd "$install_dir/funtux" || exit 1

echo "Run cat docs/INSTALL to see installation instructions for FunTux."