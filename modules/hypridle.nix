{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.hypridle.enable = lib.mkEnableOption "Aktiviert hypridle";
  };

  config = lib.mkIf config.xanterella.hypridle.enable {
    environment.systemPackages = with pkgs; [
      hypridle
    ];
    services = {
      hypridle = {
        enabel = true;
      };
    };
  };
}
