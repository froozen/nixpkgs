{ stdenv, fetchgit, perl, efivar, pciutils, zlib }:

stdenv.mkDerivation rec {
  name = "efibootmgr-${version}";
  version = "0.11.0";

  buildInputs = [ perl efivar pciutils zlib ];

  src = fetchgit {
    url = "git://github.com/rhinstaller/efibootmgr.git";
    rev = "refs/tags/${name}";
    sha256 = "1di7cipi6jh4qaiq1ckyk6aimgpagb85yr37k3c1kj1m9p5qra4j";
  };

  postPatch = ''
    substituteInPlace "./tools/install.pl" \
      --replace "/usr/bin/perl" "${perl}/bin/perl"
  '';

  installFlags = [ "BINDIR=$(out)/sbin" ];

  meta = with stdenv.lib; {
    description = "A Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager";
    homepage = http://linux.dell.com/efibootmgr/;
    license = licenses.gpl2;
    maintainers = with maintainers; [ shlevy ];
    platforms = platforms.linux;
  };
}
