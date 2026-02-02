{ lib, stdenv, fetchUrl, autoPatchelfHook, glibc, zlib, ncurses, zstd, xz, python38, libxcrypt, libxcrypt-legacy }:
let
	oldPkgs = import
		(builtins.fetchTarball {
			url = "https://github.com/NixOS/nixpkgs/archive/23.11.tar.gz";
			sha256 = "sha256:bc9a0a74e8d7fb0e11434dd3abaa0cb0572ccd3a65b5a192eea41832b286e8a0";
		}) { system = pkgs.system; };
in
	stdenv.mkDerivation {
		pname = "gcc-aarch64-none-elf";
		version = "15.2.rel1";

		src = pkgs.fetchurl {
			url = "https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-x86_64-aarch64-none-elf.tar.xz";
			sha256 = "sha256:66f7ce7c1bf662f589a4caf440812375f3cd8000a033ccf0971127a0726d6921";
		};

		nativeBuildInputs = [ autoPatchelfHook ];

		buildInputs = with pkgs; [
			stdenv.cc.cc.lib
			glibc
			zlib
			ncurses
			zstd
			xz
			oldPkgs.python38
			libxcrypt
			libxcrypt-legacy
		];

		installPhase = ''
			runHook preInstall

			mkdir -p $out
			cp -r ./* $out/

			runHook postInstall
		'';

		meta = with lib; {
			description = "GCC compiler for baremetal aarch64 architecture";
			homepage = "https://developer.arm.com/downloads/-/gnu-rm";
		};
	}
