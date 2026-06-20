{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      github-runner = {
        enable = lib.mkEnableOption "Aktiviert den GitHub Actions Runner";
      };
    };
  };

  config = lib.mkIf config.xanterella.github-runner.enable {
    age = {
      secrets = {
        github-runner-token = {
          file = ./../agenix/github-runner.age;
        };
      };
    };

    services = {
      github-runners = {
        xanterella-ci = {
          enable = true;
          url = "https://github.com/Xeravus/Xanterella-Cli";
          tokenFile = config.age.secrets.github-runner-token.path;
          extraPackages = with pkgs; [
            nix
            git
            bash
          ];
          extraLabels = [
            "nixos"
            "self-hosted"
            "xanterella"
          ];
        };
      };
    };
  };
}
