{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      netbird-server = {
        enable = lib.mkEnableOption "Aktiviert Netbird als Server modul";
      };
    };
  };
  config = lib.mkIf config.xanterella.netbird-server.enable {
    services = {
      netbird = {
        enable = true;
        package = pkgs-unstable.netbird;
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
