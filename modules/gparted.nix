{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.gparted.enable = lib.mkEnableOption "Aktiviert gparted";
  };

  config = lib.mkIf config.xanterella.gparted.enable {
    environment.systemPackages = with pkgs; [
      gparted
    ];
  };
}
