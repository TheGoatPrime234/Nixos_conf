{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.sl.enable = lib.mkEnableOption "Aktiviert sl";
  };

  config = lib.mkIf config.xanterella.sl.enable {
    environment.systemPackages = with pkgs; [
      sl
    ];
  };
}
