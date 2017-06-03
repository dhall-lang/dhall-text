{ nixpkgs, pullRequestsJSON, src }:
let
  pkgs = import nixpkgs {};

  pullRequests = builtins.fromJSON (builtins.readFile pullRequestsJSON);

  jobsets = pkgs.lib.mapAttrs (num: info: {
    enabled = 1;

    hidden = false;

    description = "Pull request #${num}: ${info.title}";

    nixexprinput = "src";

    nixexprpath = "release.nix";

    checkinterval = 240;

    schedulingshares = 1;

    enableemail = true;

    emailoverride = "";

    keepnr = 3;

    inputs = {
      src = {
        type = "git";

        value = "git://github.com/${info.head.repo.owner.login}/${info.head.repo.name}.git ${info.head.ref}";

        emailresponsible = false;
      };

      nixpkgs = {
        type = "git";

        value = "git://github.com/NixOS/nixpkgs.git";

        emailresponsible = false;
      };
    };
  }) pullRequests;
in
  { jobsets = pkgs.writeText "jobsets.json" (builtins.toJSON jobsets);
  }
