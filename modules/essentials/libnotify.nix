{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.libnotify.enable = lib.mkEnableOption "Aktiviert libnotify";
  };

  config = lib.mkIf config.xanterella.libnotify.enable {
    environment.systemPackages = with pkgs; [
      libnotify
    ];
  };
}
