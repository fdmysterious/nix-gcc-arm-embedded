{ system, lib, stdenv, fetchurl, autoPatchelfHook, glibc, zlib, ncurses, zstd, xz, libxcrypt, libxcrypt-legacy }:
let
	oldPkgs = import
		(builtins.fetchTarball {
			url = "https://github.com/NixOS/nixpkgs/archive/23.11.tar.gz";
			sha256 = "sha256:1ndiv385w1qyb3b18vw13991fzb9wg4cl21wglk89grsfsnra41k";
		}) { system = system; };
in
	stdenv.mkDerivation {
		pname = "gcc-aarch64-none-elf";
		version = "15.2.rel1";

		src = fetchurl {
			url = "https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-x86_64-aarch64-none-elf.tar.xz";
			sha256 = "sha256:66f7ce7c1bf662f589a4caf440812375f3cd8000a033ccf0971127a0726d6921";
		};

		nativeBuildInputs = [ autoPatchelfHook ];

		buildInputs = [
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
