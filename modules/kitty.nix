{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.kitty.enable = lib.mkEnableOption "Aktiviert kitty";
  };

  config = lib.mkIf config.xanterella.kitty.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];
  };
}
