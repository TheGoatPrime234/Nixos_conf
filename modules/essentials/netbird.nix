{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      netbird = {
        enable = lib.mkEnableOption "Aktiviert netbird als client";
      };
    };
  };
  config = lib.mkIf config.xanterella.netbird.enable {
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
