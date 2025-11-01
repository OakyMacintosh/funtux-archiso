#!/usr/bin/env bash
set -euo pipefail

# load profile variables so we know install_dir and arch
build() {
    if [ -f "funiso/profiledef.sh" ]; then
        # shellcheck disable=SC1091
        source funiso/profiledef.sh
    fi
    
    # Replace placeholders in boot/grub/syslinux templates so mkarchiso embeds literal paths.
    # Only replace expected tokens to avoid touching other content. Keep .bak backups.
    while IFS= read -r -d '' f; do
        sed -i.bak \
        -e "s|%INSTALL_DIR%|${install_dir}|g" \
        -e "s|%ARCH%|${arch}|g" "$f" || true
    done < <(find funiso -type f \( -name '*.cfg' -o -name '*.conf' -o -name '*.lst' -o -name '*.entry' \) -print0)
    
    # run the original build command
    sudo mkarchiso -v ./funiso
}

# Get the command argument, default to "build" if none provided
cmd="${1:-build}"

case "$cmd" in
    clean)
        sudo rm -rf out work
    ;;
    build)
        build
    ;;
    *)
        echo "Usage: $0 [build|clean]"
        echo "  build - Build the ISO (default)"
        echo "  clean - Clean build directories"
        exit 1
    ;;
esac
