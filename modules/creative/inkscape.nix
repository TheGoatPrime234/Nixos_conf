{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.inkscape.enable = lib.mkEnableOption "Aktiviert inkscape";
  };

  config = lib.mkIf config.xanterella.inkscape.enable {
    environment.systemPackages = with pkgs; [
      inkscape
    ];
  };
}
