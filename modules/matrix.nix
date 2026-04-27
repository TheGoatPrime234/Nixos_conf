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
    xanterella.matrix.enable = lib.mkEnableOption "Aktiviert matrix";
  };

  config = lib.mkIf config.xanterella.matrix.enable {
    environment.systemPackages = with pkgs; [
      element-desktop
      gomuks
    ];
  };
}
