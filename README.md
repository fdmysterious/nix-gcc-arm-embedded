# Simple nix channel for ARM baremetal gcc compilers

- Florian Dupeyron (florian.dupeyron@mugcat.fr)
- February 2026

This is a small attempt at packaging arm-provided compilers for baremetal arm targets

The following packages are provided:

- `arn-none-eabi`: Baremetal compiler for arm 32 bit architectures (also given by https://github.com/NixOS/nixpkgs/blob/nixos-25.11/pkgs/by-name/gc/gcc-arm-embedded-14/package.nix
- `aarch64-none-elf`: Baremetal compiler

**Please note**: I am not a nix expert. There is probably room for improvement.
