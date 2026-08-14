{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      syncthing = {
        enable = lib.mkEnableOption "Aktiviert syncthing";
      };
    };
  };

  config = lib.mkIf config.xanterella.syncthing.enable {
    environment = {
      systemPackages = with pkgs; [
        syncthing
      ];
    };
    systemd = {
      tmpfiles = {
        rules = [
          "d /home/cato/.local/syncthing 0750 syncthing syncthing -"
          "d /home/cato/.local/syncthing/data 0750 syncthing syncthing -"
          "d /home/cato/.local/syncthing/config 0750 syncthing syncthing -"
        ];
      };
    };
    services = {
      syncthing = {
        enable = true;
        user = "cato";
        dataDir = "/home/cato/Documents";
        configDir = "/home/cato/.config/syncthing";
        openDefaultPorts = true;
        overrideDevices = true;
        settings = {
          devices = {
            "Samsung S25+" = {
              id = "KTMXZ37-UVIDCOC-SSPXJDV-HSL2KE7-DYGTDRQ-RWUUNSH-PMBACVF-UUJOSAE";
              autoAcceptFolders = true;
            };
          };
          folder = {
            "Vaults" = {
              enable = true;
              id = "ngxgj-f2ouz";
              path = "~/Documents/Vaults/";
              devices = [
                "Samsung S25+"
              ];
              versioning = {
                type = "staggered";
                params = {
                  cleanInterval = "3600";
                  maxAge = "1000000";
                };
              };
            };
          };
        };
      };
    };
  };
}
