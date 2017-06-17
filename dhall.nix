{ mkDerivation, ansi-wl-pprint, base, bytestring, case-insensitive
, charset, containers, http-client, http-client-tls, lens
, neat-interpolation, optparse-generic, parsers, stdenv
, system-fileio, system-filepath, tasty, tasty-hunit, text
, text-format, transformers, trifecta, unordered-containers, vector
}:
mkDerivation {
  pname = "dhall";
  version = "1.4.2";
  sha256 = "0wnfqm0478h9fqav13q6fqnj8fzbhigsndnasr0hbcjd3s3qvf0d";
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    ansi-wl-pprint base bytestring case-insensitive charset containers
    http-client http-client-tls lens neat-interpolation parsers
    system-fileio system-filepath text text-format transformers
    trifecta unordered-containers vector
  ];
  executableHaskellDepends = [ base optparse-generic text trifecta ];
  testHaskellDepends = [
    base neat-interpolation tasty tasty-hunit text vector
  ];
  description = "A configuration language guaranteed to terminate";
  license = stdenv.lib.licenses.bsd3;
}
