{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.xyy.enable = lib.mkEnableOption "Aktiviert xyy";
  };

  config = libmkIF config.xanterella.xyy.enable {
    goon.enable = true;
  };
}
