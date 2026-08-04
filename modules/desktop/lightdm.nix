{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      lightdm = {
        enable = lib.mkEnableOption "Aktiviert LightDm";
      };
    };
  };

  config = lib.mkIf config.xanterella.lightdm.enable {
    services.xserver.displayManager.lightdm.greeters.gtk.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
  };
}
