{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.obsidian.enable = lib.mkEnableOption "Aktiviert obsidian";
  };

  config = lib.mkIf config.xanterella.obsidian.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
