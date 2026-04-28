{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.colmena.enable = lib.mkEnableOption "Aktiviert colmena";
  };

  config = lib.mkIf config.xanterella.colmena.enable {
    environment.systemPackages = with pkgs; [
      colmena
    ];
  };
}
