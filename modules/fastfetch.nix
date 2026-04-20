{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.fastfetch.enable = lib.mkEnableOption "Aktiviert fastfetch";
  };

  config = libmkIF config.xanterella.fastfetch.enable {
    environment.systemPackages = with pkgs; [
      fastfetch
    ];
  };
}
