{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.gamemode.enable = lib.mkEnableOption "Aktiviert gamemode";
  };

  config = lib.mkIf config.xanterella.gamemode.enable {
    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;
      };
    };
  };
}
