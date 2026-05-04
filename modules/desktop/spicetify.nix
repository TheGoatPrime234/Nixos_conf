{
  config,
  pkgs,
  lib,
  inputs,
  pkgs-25-11,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  spotify-fix = pkgs.symlinkJoin {
    name = "spotify-fix";
    pname = "spotify";
    version = pkgs.spotify.version;
    meta = pkgs.spotify.meta;
    paths = [
      pkgs.spotify
    ];
    buildInputs = [
      pkgs.makeWrapper
    ];
    postBuild = ''
      wrapProgram $out/bin/spotify \
      --add-flags "--disable-gpu"
    '';
  };
in {
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];
  options = {
    xanterella.spicetify.enable = lib.mkEnableOption "Aktiviert spicetify";
  };

  config = lib.mkIf config.xanterella.spicetify.enable {
    environment = {
      systemPackages = [
        pkgs-25-11.spotify-player
        pkgs.sptlrx
      ];
    };
    programs = {
      spicetify = {
        enable = true;
        spotifyPackage = spotify-fix;
        enabledExtensions = with spicePkgs.extensions; [
          hidePodcasts
          shuffle
        ];
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };
    };
  };
}
