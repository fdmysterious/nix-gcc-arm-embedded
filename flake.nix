{
  description = "My custom packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"
      ];
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
		  aarch64-none-elf = pkgs.callPackage ./pkgs/aarch64-none-elf.nix {};
        });

      # Optional: expose the set under legacy ‘channel’ names
      legacyPackages = self.packages;
    };
}
