{
  pkgs-unstable,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.xanterella.jellyfin;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      jellyfin = {
        enable = lib.mkEnableOption "Aktiviert Jellyfin";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:1009";
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    age = {
      secrets = {
        rclone-conf = {
          file = ./../agenix/rclone.conf.age;
          owner = "root";
          group = "root";
          mode = "0400";
        };
      };
    };
    environment = {
      systemPackages = with pkgs-unstable; [
        rclone
      ];
    };
    services = {
      jellyfin = {
        enable = true;
        package = pkgs-unstable.jellyfin;
      };
      caddy = {
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:8096 {
              	flush_interval -1
                  }

                  request_body {
              	max_size 0
                  }
            '';
          };
        };
      };
    };
    programs = {
      fuse = {
        userAllowOther = true;
      };
    };
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/jellyfin 0775 root root -"
          "d /mnt/server-data/jellyfin 0775 root root -"
          "d /mnt/server-data/jellyfin/s3-media 0775 root root -"
        ];
      };
      services = {
        rclone-s3-mount = {
          description = "Rclone Mount für Garage S3 Storage";
          requires = ["network-online.target"];
          after = ["network-online.target"];
          wantedBy = ["multi-user.target"];

          serviceConfig = {
            Type = "notify";
            ExecStart = ''
              ${pkgs.rclone}/bin/rclone mount garage-s3:jellyfin-bucket /mnt/server-data/jellyfin/s3-media \
                --config=${config.age.secrets.rclone-conf.path} \
                --allow-other \
                --vfs-cache-mode full \
                --vfs-cache-max-size 200G \
                --vfs-read-chunk-size 32M \
                --dir-cache-time 72h \
                --log-level INFO \
                --syslog
            '';
            ExecStop = "${pkgs.fuse}/bin/fusermount -u /mnt/server-data/jellyfin/s3-media";
            Restart = "on-failure";
            RestartSec = "10s";
          };
        };
      };
    };
  };
}
