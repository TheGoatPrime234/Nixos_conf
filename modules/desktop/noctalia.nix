{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.xanterella.noctalia;

  noctaliaConfigFile = ./noctalia.toml;
in {
  options = {
    xanterella = {
      noctalia = {
        enable = lib.mkEnableOption "Aktiviert Noctalia deklarativ über tmpfiles";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      etc = {
        "wallpaper" = {
          source = inputs.wallpaper;
        };
      };
      systemPackages = [
        inputs.noctalia.packages.${pkgs.system}.default
      ];
    };
    systemd.user.tmpfiles.rules = [
      "d %h/.config/noctalia 0755 - - -"
      "L+ %h/.config/noctalia/config.toml - - - - ${noctaliaConfigFile}"
    ];
  };
}
