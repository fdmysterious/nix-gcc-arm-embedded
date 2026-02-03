{ lib, stdenv, fetchurl, autoPatchelfHook, glibc, zlib, ncurses, zstd, xz, libxcrypt, libxcrypt-legacy }:
let
	oldPkgs = import
		(builtins.fetchTarball {
			url = "https://github.com/NixOS/nixpkgs/archive/23.11.tar.gz";
			sha256 = "sha256:1ndiv385w1qyb3b18vw13991fzb9wg4cl21wglk89grsfsnra41k";
		}) { system = stdenv.hostPlatform.system; };
in
	stdenv.mkDerivation {
		pname = "arm-none-eabi";
		version = "15.2.rel1";

		src = fetchurl {
			url = "https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-eabi.tar.xz";
			sha256 = "sha256:597893282ac8c6ab1a4073977f2362990184599643b4c5ee34870a8215783a16";
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
			description = "GCC compiler for baremetal arm architecture";
			homepage = "https://developer.arm.com/downloads/-/gnu-rm";
		};
	}
