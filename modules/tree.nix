{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.tree.enable = lib.mkEnableOption "Aktiviert tree";
  };

  config = lib.mkIf config.xanterella.tree.enable {
    environment.systemPackages = with pkgs; [
      tree
    ];
  };
}
