let
	pkgs = import <nixpkgs> {};
in
{
	gcc-aarch64-none-elf = pkgs.callPackage ./pkgs/gcc-aarch64-none-elf.nix {};
}
