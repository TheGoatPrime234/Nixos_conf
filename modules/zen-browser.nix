{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  options = {
    xanterella.zen-browser.enable = lib.mkEnableOption "Aktiviert zen-browser";
  };

  config = lib.mkIf config.xanterella.zen-browser.enable {
    environment.systemPackages = with pkgs; [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
  };
}
