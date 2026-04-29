{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.gnome-keyring.enable = lib.mkEnableOption "Aktiviert gnome-keyring";
  };

  config = lib.mkIf config.xanterella.gnome-keyring.enable {
    services = {
      gnome = {
        gnome-keyring = {
          enable = true;
        };
      };
    };
  };
}
