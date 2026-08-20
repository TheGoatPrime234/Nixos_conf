{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.xanterella.opsbot;
  nodeCfg = config.xanterella.cluster-ndoe;
  opsbot-script =
    pkgs.writers.writePython3Bin "opsbot" {
      libraries = [pkgs.python3Packages.simplematrixbotlib];
    } ''
      import simplematrixbotlib as botlib
      import subprocess
      import sys

      try:
          with open("/run/agenix/matrix-bot-token", "r") as f:
              token = f.read().strip()
      except FileNotFoundError:
          print("Fehler: Token-Datei nicht gefunden!")
          sys.exit(1)

      creds = botlib.Creds("https://${nodeCfg.domain}", "@opsbot:${nodeCfg.domain}", token)
      bot = botlib.Bot(creds)

      ALLOWED_USER = "@xeravus:${nodeCfg.domain}"

      @bot.listener.on_message_event
      async def handle_commands(room, message):
          if message.sender != ALLOWED_USER:
              return

          if message.body == "!start_lab":
              subprocess.run(["sudo", "/run/current-system/sw/bin/systemctl", "start", "podman-metasploitable.service"])
              await bot.api.send_text_message(room.room_id, "Metasploitable gestartet! Viel Spaß beim Hacken unter 10.99.99.1.")

          elif message.body == "!stop_lab":
              subprocess.run(["sudo", "/run/current-system/sw/bin/systemctl", "stop", "podman-metasploitable.service"])
              await bot.api.send_text_message(room.room_id, "Lab erfolgreich heruntergefahren.")

      bot.run()
    '';
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
          file = ./../secrets/matrix-opsbot-token;
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
