{
  config,
  lib,
  pkgs,
  pkgs-bleeding,
  ...
}: {
  options = {
    xanterella = {
      netbird = {
        enable = lib.mkEnableOption "Aktiviert netbird als Client";
      };
    };
  };
  config = lib.mkIf config.xanterella.netbird.enable {
    age = {
      secrets = {
        netbird-env = {
          file = ./../agenix/netbird.env.age;
        };
      };
    };
    services = {
      netbird = {
        enable = true;
        package = pkgs-bleeding.netbird;
        clients = {
          "${config.networking.hostName}" = {
            autoStart = true;
            login = {
              enable = true;
              setupKeyFile = config.age.secrets.netbird-env.path;
            };
            port = 51820;
          };
        };
      };
    };
    networking = {
      firewall = {
        allowedUDPPorts = [
          51820
        ];
      };
    };
  };
}
