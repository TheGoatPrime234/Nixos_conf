{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.cava.enable = lib.mkEnableOption "Aktiviert cava";
  };

  config = lib.mkIf config.xanterella.cava.enable {
    environment.systemPackages = with pkgs; [
      cava
    ];
  };
}
