{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.steam.enable = lib.mkEnableOption "Aktiviert steam";
  };

  config = lib.mkIf config.xanterella.steam.enable {
    environment.systemPackages = with pkgs; [
      steam
    ];
    programs = {
      steam = {
        enable = true;
        gamescopeSession = {
          enable = true;
        };
      };
    };
  };
}
