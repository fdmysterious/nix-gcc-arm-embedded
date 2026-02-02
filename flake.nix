{
	description = "Test package gcc";

	inputs.nixpkgs.url = "nixpkgs/nixos-25.11";
	inputs.nixpkgsOld.url = "nixpkgs/nixos-23.11";

	outputs = { self, nixpkgs, nixpkgsOld }:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
			pkgsOld = nixpkgsOld.legacyPackages.${system};
		in {
			packages.${system}.default = pkgs.stdenv.mkDerivation {
				pname = "gcc-aarch64-none-elf";
				version = "15.2.rel1";

				src = pkgs.fetchurl {
					url = "https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-x86_64-aarch64-none-elf.tar.xz";
					sha256 = "sha256:66f7ce7c1bf662f589a4caf440812375f3cd8000a033ccf0971127a0726d6921";
				};

				nativeBuildInputs = with pkgs; [ autoPatchelfHook ];

				buildInputs = with pkgs; [
					stdenv.cc.cc.lib
					glibc
					zlib
					ncurses
					zstd
					xz
					pkgsOld.python38
					libxcrypt
					libxcrypt-legacy
				];
i
				installPhase = ''
					runHook preInstall

					mkdir -p $out
					cp -r ./* $out/

					runHook postInstall
				'';
			};
		};
}
