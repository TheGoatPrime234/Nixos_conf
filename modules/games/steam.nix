{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      steam = {
        enable = lib.mkEnableOption "Aktiviert steam";
      };
    };
  };

  config = lib.mkIf config.xanterella.steam.enable {
    environment = {
      systemPackages = with pkgs-unstable; [
        steam
      ];
    };
    programs = {
      steam = {
        enable = true;
        gamescopeSession = {
          enable = true;
        };
        extraCompatPackages = with pkgs-unstable; [
          proton-ge-bin
        ];
      };
    };

    environment = {
      sessionVariables = {
        STEAM_EXTRA_COMPACT_TOOLS_PATH = "/home/cato/.steam/root/compatibilitytools.d";
      };
    };
  };
}
