{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.geistmono.enable = lib.mkEnableOption "Aktiviert geistmono";
  };

  config = lib.mkIf config.xanterella.geistmono.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override {fonts = ["GeistMono"];})
    ];
  };
}
