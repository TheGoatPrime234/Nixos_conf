{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.xanterella.syncthing_server;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      syncthing_server = {
        enable = lib.mkEnableOption "Aktiviert Syncthing_server ohne externes Speichermedium";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:6";
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
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
          "d /mnt/server-data/syncthing 0750 syncthing syncthing -"
          "d /mnt/server-data/syncthing/data 0750 syncthing syncthing -"
          "d /mnt/server-data/syncthing/config 0750 syncthing syncthing -"
        ];
      };
    };
    services = {
      syncthing = {
        enable = true;
        systemService = true;
        dataDir = "/mnt/server-data/syncthing/data";
        configDir = "/mnt/server-data/syncthing/config";
        user = "syncthing";
        group = "syncthing";
        guiAddress = "127.0.0.1:8284";
        guiPasswordFile = config.age.secrets.gui-password.path;
        settings = {
          gui = {
            insecureSkipHostcheck = true;
          };
          devices = {
            "Samsung S25+" = {
              id = "KTMXZ37-UVIDCOC-SSPXJDV-HSL2KE7-DYGTDRQ-RWUUNSH-PMBACVF-UUJOSAE";
              autoAcceptFolders = true;
            };
            "Lutik" = {
              id = "QCGYDG6-3JIVU2A-LJATSGN-MAJV2GX-VZCFJHE-OXZXNFV-GDQL7TK-B7MHOAC";
              autoAcceptFolders = true;
            };
            "Xorus" = {
              id = "OLIYCOU-35J6CBI-ROHN6GJ-JXY42PF-DO7JGDA-HSTC7PN-XIVDEZ5-6KBNDQ6";
              autoAcceptFolders = true;
            };
            "Xeravus" = {
              id = "U6WAEJX-YTJLVVL-GDOM62T-ES7I4FJ-C7IKTYG-ZEY2FS3-2SVKE4Y-FZEY4QX";
              autoAcceptFolders = true;
            };
          };
          folders = {
            "Vaults" = {
              enable = true;
              id = "ngxgj-f2ouz";
              path = "/mnt/server-path/syncthing/folders/vaults";
              devices = [
                "Xeravus"
                "Xorus"
                "Lutik"
                "Samsung S25+"
              ];
            };
          };
        };
      };
      caddy = {
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              reverse_proxy ${config.services.syncthing.guiAddress}
            '';
          };
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
  };
}
