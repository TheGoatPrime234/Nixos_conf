{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  options = {
    xanterella = {
      makemkv = {
        enable = lib.mkEnableOption "Aktiviert makemkv";
      };
    };
  };

  config = lib.mkIf config.xanterella.makemkv.enable {
    boot = {
      kernelModules = ["sg"];
    };
    users = {
      users = {
        cato = {
          extraGroups = ["cdrom" "video"];
        };
      };
    };
    virtualisation = {
      oci-containers = {
        containers = {
          makemkv = {
            image = "jlesage/makemkv";
            environment = {
              TZ = "Europe/Berlin";
              USER_ID = "1000";
              GROUP_ID = "100";
            };
            ports = [
              "5800:5800"
            ];
            volumes = [
              "/mnt/server-data/makemkv/config:/config"
              "/mnt/server-data/makemkv/storage:/storage"
            ];
            extraOptions = [
              "--device=/dev/sr0:/dev/sr0"
              "--device=/dev/sg0:/dev/sg0"
              # "--privileged" # Nur einkommentieren, falls das Laufwerk im Container fehlt
            ];
            autoStart = true;
          };
        };
      };
    };
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/makemkv 0775 cato cato -"
          "d /mnt/server-data/makemkv/config 0775 cato cato -"
          "d /mnt/server-data/makemkv/storage 0775 cato cato -"
        ];
      };
    };
    environment = {
      systemPackages = with pkgs-unstable; [
        makemkv
      ];
    };
  };
}
