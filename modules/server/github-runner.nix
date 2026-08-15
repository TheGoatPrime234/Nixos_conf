{
  config,
  lib,
  pkgs-unstable,
  ...
}: let
  cfg = config.xanterella.github-runner;
in {
  options = {
    xanterella = {
      github-runner = lib.mkOption {
        default = {};
        type = lib.types.attrsOf (lib.types.submodule {
          options = {
            url = lib.mkOption {
              type = lib.types.str;
            };
            labels = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [];
            };
          };
        });
      };
    };
  };
  config = lib.mkIf (cfg != {}) {
    age = {
      secrets = {
        github-runner-token = {
          file = ./../agenix/github-runner.age;
        };
      };
    };
    services = {
      github-runners =
        lib.mapAttrs (runnerName: runnerCfg: {
          enable = true;
          package = pkgs-unstable.github-runner;
          name = "${config.networking.hostName}-${runnerName}";
          url = runnerCfg.url;
          tokenFile = config.age.secrets.github-runner-token.path;
          extraLabels = runnerCfg.labels;
          nodeRuntimes = ["node24"];
          replace = true;
          extraPackages = with pkgs-unstable; [
            git
            nodejs
            bash
          ];
        })
        cfg;
    };
  };
}
