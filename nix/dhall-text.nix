{ mkDerivation, base, dhall, optparse-generic, stdenv, text }:
mkDerivation {
  pname = "dhall-text";
  version = "1.0.9";
  src = ./..;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base dhall optparse-generic text ];
  description = "Template text using Dhall";
  license = stdenv.lib.licenses.bsd3;
}
