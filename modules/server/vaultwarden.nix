{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.vaultwarden.enable = lib.mkEnableOption "Aktiviert vaultwarden";
  };

  config = lib.mkIf config.xanterella.vaultwarden.enable {
    environment.systemPackages = with pkgs; [
      vaultwarden
    ];
    systemd = {
      services = {
        vaultwarden = {
          serviceConfig = {
            ReadWritePaths = [
              "/mnt/data/nix/vaultwarden"
            ];
          };
        };
      };
      tmpfiles = {
        rules = [
          "d /mnt/data/nix/vaultwarden 0750 vaultwarden vaultwarden -"
        ];
      };
    };
    services = {
      vaultwarden = {
        enable = true;
        config = {
          DATA_FOLDER = "/mnt/data/nix/vaultwarden";
          ROCKET_ADDRESS = "0.0.0.0";
          ROCKET_PORT = 8222;
        };
      };
    };
    networking = {
      firewall = {
        allowedTCPPorts = [
          8222
        ];
      };
    };
  };
}
