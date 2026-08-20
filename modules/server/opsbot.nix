{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.xanterella.opsbot;
  nodeCfg = config.xanterella.cluster-node;
  opsbot-script = pkgs.writers.writePython3Bin "opsbot" {
    libraries = [pkgs.python3Packages.matrix-nio];
    flakeIgnore = ["E501" "E302" "E305" "F401" "E265"];
  } (builtins.readFile ./opsbot.py);
in {
  options = {
    xanterella = {
      opsbot = {
        enable = lib.mkEnableOption "Aktiviert OpsBot ein Matrix Bot";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}";
        };
      };
    };
  };
  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    age = {
      secrets = {
        matrix-opsbot-token = {
          file = ./../agenix/matrix-opsbot-token.age;
          owner = "opsbot";
        };
      };
    };
    users = {
      groups = {
        opsbot = {};
      };
      users = {
        opsbot = {
          isSystemUser = true;
          group = "opsbot";
        };
      };
    };
    systemd = {
      services = {
        opsbot = {
          description = "Matrix ChatOps Bot";
          wantedBy = ["multi-user.target"];
          after = ["network-online.target"];
          wants = ["network-online.target"];
          serviceConfig = {
            ExecStart = "${opsbot-script}/bin/opsbot";
            User = "opsbot";
            Group = "opsbot";
            Restart = "always";
            RestartSec = "10s";
          };
        };
      };
    };
    security = {
      sudo = {
        extraRules = [
          {
            users = ["opsbot"];
            commands = [
              {
                command = "/run/current-system/sw/bin/systemctl start podman-metasploitable.service";
                options = ["NOPASSWD"];
              }
              {
                command = "/run/current-system/sw/bin/systemctl stop podman-metasploitable.service";
                options = ["NOPASSWD"];
              }
            ];
          }
        ];
      };
    };
  };
}
