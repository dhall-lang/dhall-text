{ mkDerivation, ansi-wl-pprint, base, bytestring, charset
, containers, fetchgit, http-client, http-client-tls, lens
, neat-interpolation, optparse-generic, parsers, stdenv
, system-fileio, system-filepath, tasty, tasty-hunit, text
, text-format, transformers, trifecta, unordered-containers, vector
}:
mkDerivation {
  pname = "dhall";
  version = "1.3.0";
  src = fetchgit {
    url = "https://github.com/Gabriel439/Haskell-Dhall-Library.git";
    sha256 = "0hjww2wsgnx425icp06dc42pndzvdr2cfpz7l7nzd4hisl1r1mzr";
    rev = "c15eebf9352cc064ed67fa1373773515fea3a964";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    ansi-wl-pprint base bytestring charset containers http-client
    http-client-tls lens neat-interpolation parsers system-fileio
    system-filepath text text-format transformers trifecta
    unordered-containers vector
  ];
  executableHaskellDepends = [ base optparse-generic text trifecta ];
  testHaskellDepends = [
    base neat-interpolation tasty tasty-hunit text vector
  ];
  description = "A configuration language guaranteed to terminate";
  license = stdenv.lib.licenses.bsd3;
}
