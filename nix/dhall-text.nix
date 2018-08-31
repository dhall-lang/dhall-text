{ mkDerivation, base, dhall, optparse-applicative, stdenv, text }:
mkDerivation {
  pname = "dhall-text";
  version = "1.0.12";
  src = ./..;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base dhall optparse-applicative text
  ];
  description = "Template text using Dhall";
  license = stdenv.lib.licenses.bsd3;
}
