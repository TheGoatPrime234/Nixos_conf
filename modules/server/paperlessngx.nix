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
    age = {
      secrets = {
        paperless-pass = {
          file = ./../agenix/paperless-pass.age;
          owner = "paperless";
        };
      };
    };
    services = {
      paperless = {
        enable = true;
        dataDir = "/mnt/server-data/paperlessngx";
        mediaDir = "/mnt/server-data/paperlessngx/media";
        consumptionDir = "/mnt/server-data/paperlessngx/consume";
        address = "0.0.0.0";
        port = 2731;
        passwordFile = config.age.secrets.paperless-pass.path;
        settings = {
          PAPERLESS_ADMIN_USER = "admin";
          PAPERLESS_URL = "https://${cfg.domain}";
          PAPERLESS_TIME_ZONE = "Europe/Berlin";
          PAPERLESS_OCR_LANGUAGE = "deu+eng";
          PAPERLESS_TASK_WORKERS = 1;
          PAPERLESS_THREADS_PER_WORKER = 2;
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
