{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.nix-switcher.enable = lib.mkEnableOption "Aktiviert nix-switcher für Hyprland";
  };

  config = lib.mkIf config.xanterella.nix-switcher.enable {
    environment.systemPackages = [
      inputs.nix-programs.packages.${pkgs.system}.switcher
      pkgs.lutgen
    ];
  };
}
