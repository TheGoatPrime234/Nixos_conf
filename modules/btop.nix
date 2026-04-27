{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.btop.enable = lib.mkEnableOption "Aktiviert btop";
  };

  config = lib.mkIf config.xanterella.btop.enable {
    environment.systemPackages = with pkgs; [
      btop
    ];
  };
}
