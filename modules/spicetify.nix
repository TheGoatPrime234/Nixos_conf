{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackges.${pkgs.systen};
in {
  options = {
    xanterella.spicetify.enable = lib.mkEnableOption "Aktiviert spicetify";
  };

  config = lib.mkIf config.xanterella.spicetify.enable {
    programs.spicetify = {
      enable = true;
      enableExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle
      ];
      theme = spicePkgs.themes.catppuccin;
      colorSheme = "mocha";
    };
  };
}
