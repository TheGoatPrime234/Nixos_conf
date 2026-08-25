{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.xanterella.paperlessngx;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      paperlessngx = {
        enable = lib.mkEnableOption "Aktiviert paperlessngx";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:1007";
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    services.paperless = {
      enable = true;
      dataDir = "/mnt/server-data/paperlessngx";
      mediaDir = "/mnt/server-data/paperlessngx/media";
      consumptionDir = "/mnt/server-data/paperlessngx/consume";
      passwordFile = builtins.toFile "paperless-pass" "admin";
      settings = {
        PAPERLESS_ADMIN_USER = "admin";
        PAPERLESS_URL = "https://${cfg.domain}";
        PAPERLESS_TIME_ZONE = "Europe/Berlin";
        PAPERLESS_OCR_LANGUAGE = "deu+eng";
        PAPERLESS_TASK_WORKERS = 1;
        PAPERLESS_THREADS_PER_WORKER = 2;
      };
    };
    services = {
      caddy = {
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:${toString config.services.paperless.port}
            '';
          };
        };
      };
    };
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/paperlessngx 0750 paperless paperless -"
          "d /mnt/server-data/paperlessngx/media 0750 paperless paperless -"
          "d /mnt/server-data/paperlessngx/consume 0770 paperless paperless -"
        ];
      };
    };
  };
}
