# funtux-archiso

Minimal, reproducible project for building a customized Arch Linux live ISO for installing FunTux using archiso.

## What this is
A small build environment and configuration for producing a custom Arch-based live image (ISO). Intended to be used with the upstream archiso tooling and simple, repeatable build recipes.

## Features
- Buildable with archiso
- Profile-based configuration (packages, hooks, overlays)
- Simple workflow for iterating and testing images

## Prerequisites
- A working Arch Linux environment (or container) with root or sudo
- Installed packages:
    - archiso
    - git
    - QEMU (optional, for testing)
Example:
```bash
sudo pacman -Syu archiso git qemu
```

## Repository layout (typical)
```
/configs/
    /releng/           # example profile used to build the ISO
        pacman.conf
        packages.x86_64
        airootfs/        # files that get copied into the live system
        profiledef.sh    # metadata and bootstrap settings
build.sh             # optional wrapper script
```

## Quickstart — build an ISO
1. Clone the repo (if not already):
```bash
git clone /home/oaky/Projects/funtux-archiso .
```
2. Build using archiso:
```bash
# from repo root
sudo mkarchiso -v -w work -o out configs/releng
```
- Output ISO will be in `out/`.
- `work/` is a temporary working directory you can remove after success.

If you include a `build.sh`, you may instead run:
```bash
./build.sh
```

## Customize
- Add or remove packages: edit `configs/releng/packages.x86_64`.
- Add files to the live system: place them under `configs/releng/airootfs/`.
- Modify boot and system settings via `profiledef.sh` and `pacman.conf`.
- Add hooks in `airootfs/etc` or custom build hooks in the profile directory.

## Test the ISO
Run in QEMU for quick validation:
```bash
qemu-system-x86_64 -m 2048 -cdrom out/*.iso -boot d
```

## Clean up
Remove the working directory and output ISO when done:
```bash
rm -rf work out
```

## Contributing
- Keep changes focused and small.
- Update package lists and airootfs contents with clear commit messages.
- Test builds locally before submitting changes.

## License
See LICENSE (MIT) in the repository.

---
