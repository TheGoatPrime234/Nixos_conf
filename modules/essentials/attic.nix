{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      attic = {
        enable = lib.mkEnableOption "Aktiviert attic";
      };
    };
  };

  config = lib.mkIf config.xanterella.attic.enable {
    environment = {
      systemPackages = with pkgs; [
        attic-client
      ];
    };
    nix = {
      settings = {
        substituters = [
          "https://lutik.gute-nessie.ts.net/main"
        ];
        trusted-public-keys = [
          "main:bLMFpRICiPB1bYrlJCfFuYthr3VG5Xhmcz2R6rubCFc="
        ];
      };
    };
    systemd = {
      user = {
        services = {
          attic-watch-store = {
            description = "Attic watch-store daemon";
            wantedBy = [
              "default.target"
            ];
            after = [
              "network-online.target"
            ];
            serviceConfig = {
              ExecStart = "${pkgs.attic-client}/bin/attic watch-store xanterella:main -j 1";
              Restart = "always";
              RestartSec = "10";
            };
          };
        };
      };
    };
  };
}
