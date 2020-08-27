{ pkgs ? import <nixpkgs> {} }:

let intel2GAS = pkgs.stdenv.mkDerivation rec {
	name = "intel2GAS";

	src = builtins.fetchurl {
		url    = "http://ftp.debian.org/debian/pool/main/i/intel2gas/intel2gas_1.3.3.orig.tar.gz";
		sha256 = "0f4mcs5z41n211g5mlrq1szgp3r0x25hrx4chy718k5igi1mbfwa";
	};

	# Required to build intel2gas. Compiling this may spew out some warnings,
	# but they're safe to ignore. The entire compilation should take a few
	# seconds.
	preBuild = ''
		export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -fpermissive"
	'';
};

in pkgs.mkShell {
	# TODO: intel2gas Python

	buildInputs = [ intel2GAS ] ++ (with pkgs; [
		a2ps
		automake
		autoconf
		cimg
		clang
		clang-tools
		cscope
		curl
		enscript
		gpp
		gcc9
		gdb
		git
		glibc
		glibcInfo
		gnupg
		gthumb
		libcxx
		libcxxabi
		readline
		lldb
		nasm
		nfs-utils
		subversion
		
		# Google Test Libraries.
		gtest
		gmock

		gnome3.seahorse
	]);
}
