{
  description = "gcc packages for baremetal applications on arm architectures";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  inputs.flake-compat = {
	  url = "github:NixOS/flake-compat";
	  flake = false;
  };

  outputs = { self, nixpkgs, flake-compat }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux" #"aarch64-linux" "x86_64-darwin" "aarch64-darwin"
      ];
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
		  aarch64-none-elf = pkgs.callPackage ./pkgs/aarch64-none-elf.nix {};
		  arm-none-eabi = pkgs.callPackage ./pkgs/arm-none-eabi.nix {};
        });

      # Optional: expose the set under legacy ‘channel’ names
      legacyPackages = self.packages;
    };
}
