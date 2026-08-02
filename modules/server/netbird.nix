{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      netbird-server = {
        enable = lib.mkEnableOption "Aktiviert Netbird als Server modul";
      };
    };
  };
  config = lib.mkIf config.xanterella.netbird-server {
    services = {
      resolved = {
        enable = true;
      };
      netbird = {
      enable = true;
      };
    };
  };
}
