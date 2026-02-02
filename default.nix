let
	pkgs = import <nixpkgs> {};
in
{
	aarch64-none-elf = pkgs.callPackage ./pkgs/aarch64-none-elf.nix {};
}
