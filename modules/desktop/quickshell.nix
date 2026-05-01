{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  pkgs-25-11 = inputs.nixpkgs-25-11.legacyPackages.${pkgs.system};
in {
  options = {
    xanterella.quickshell.enable = lib.mkEnableOption "Aktiviert quickshell";
  };

  config = lib.mkIf config.xanterella.quickshell.enable {
    environment.systemPackages = with pkgs-25-11; [
      quickshell
    ];
    environment.variables = {
      QML_XHR_ALLOW_FILE_READ = "1";
    };
  };
}
