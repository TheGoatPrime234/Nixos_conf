{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.wlogout.enable = lib.mkEnableOption "Aktiviert wlogout";
  };

  config = lib.mkIf config.xanterella.wlogout.enable {
    environment.systemPackages = with pkgs; [
      wlogout
    ];
  };
}
