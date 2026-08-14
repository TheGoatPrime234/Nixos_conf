{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      syncthing_server = {
        enable = lib.mkEnableOption "Aktiviert Syncthing_server ohne externes Speichermedium";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/syncthing";
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.syncthing_server.enable {
      age = {
        secrets = {
          gui-password = {
            file = ./../agenix/syncthing.age;
          };
        };
      };
      environment = {
        systemPackages = with pkgs; [
          syncthing
        ];
      };
      systemd = {
        tmpfiles = {
          rules = [
            "d /mnt/server-data/nix/syncthing 0750 syncthing syncthing -"
            "d /mnt/server-data/nix/syncthing/data 0750 syncthing syncthing -"
            "d /mnt/server-data/nix/syncthing/config 0750 syncthing syncthing -"
          ];
        };
      };
      services = {
        syncthing = {
          enable = true;
          systemService = true;
          dataDir = "/mnt/server-data/nix/syncthing/data";
          configDir = "/mnt/server-data/nix/syncthing/config";
          user = "syncthing";
          group = "syncthing";
          guiAddress = "127.0.0.1:8284";
          guiPasswordFile = config.age.secrets.gui-password.path;
          settings = {
            gui = {
              insecureSkipHostcheck = true;
            };
            devices = {
              "Xeravus" = {
                id = "U6WAEJX-YTJLVVL-GDOM62T-ES7I4FJ-C7IKTYG-ZEY2FS3-2SVKE4Y-FZEY4QX";
                autoAcceptFolders = true;
              };
              "Samsung S25+" = {
                id = "KTMXZ37-UVIDCOC-SSPXJDV-HSL2KE7-DYGTDRQ-RWUUNSH-PMBACVF-UUJOSAE";
              };
            };
            folders = {
              "Vault" = {
                id = "ngxgj-f2ouz";
                path = "/mnt/server-path/nix/syncthing/folders/vault";
                devices = [
                  "Xeravus"
                  "Samsung S25+"
                ];
              };
            };
          };
        };
        tailscale = {
          permitCertUid = "caddy";
        };
        caddy = {
          enable = true;
          virtualHosts = {
            "https://${config.xanterella.syncthing_server.domain}:8384" = {
              extraConfig = ''
                reverse_proxy ${config.services.syncthing.guiAddress}
              '';
            };
          };
        };
      };
      users = {
        users = {
          caddy = {
            extraGroups = [
              "tailscale"
            ];
          };
        };
      };
      networking = {
        firewall = {
          allowedTCPPorts = [
            22000
            8384
          ];
          allowedUDPPorts = [
            22000
            21027
          ];
        };
      };
    })
  ];
}
