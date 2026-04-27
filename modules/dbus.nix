{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.dbus.enable = lib.mkEnableOption "Aktiviert dbus";
  };

  config = lib.mkIf config.xanterella.dbus.enable {
    environment.systemPackages = with pkgs; [
      dbus
    ];
    services = {
      dbus = {
        enable = true;
      };
    };
  };
}
