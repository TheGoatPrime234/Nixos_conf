{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.opengl.enable = lib.mkEnableOption "Aktiviert opengl";
  };

  config = lib.mkIf config.xanterella.opengl.enable {
    hardware = {
      opengl = {
        enable = true;
        driSupport32Bit = true;
      };
    };
  };
}
