{
  config,
  pkgs,
  lib,
  pkgs-25-11,
  ...
}: {
  options = {
    xanterella.colmena.enable = lib.mkEnableOption "Aktiviert colmena";
  };

  config = lib.mkIf config.xanterella.colmena.enable {
    environment.systemPackages = with pkgs-25-11; [
      colmena
      nix-output-monitor
    ];
  };
}
