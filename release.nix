# You can build this repository using Nix by running:
#
#     $ nix-build -A dhall-text release.nix
#
# You can also open up this repository inside of a Nix shell by running:
#
#     $ nix-shell -A dhall-text.env release.nix
#
# ... and then Nix will supply the correct Haskell development environment for
# you
let
  config = {
    packageOverrides = pkgs: {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: {
          dhall = haskellPackagesNew.callPackage ./dhall.nix { };

          dhall-text =
            pkgs.haskell.lib.justStaticExecutables
              (haskellPackagesNew.callPackage ./default.nix { });

          prettyprinter = haskellPackagesNew.callPackage ./prettyprinter.nix { };
        };
      };
    };
  };

  pkgs =
    import <nixpkgs> { inherit config; };

in
  { dhall-text = pkgs.haskellPackages.dhall-text;
  }
