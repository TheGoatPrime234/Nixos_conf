{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      attic = {
        enable = lib.mkEnableOption "Aktiviert attic";
      };
    };
  };

  config = lib.mkIf config.xanterella.attic.enable {
    environment = {
      systemPackages = with pkgs; [
        attic-client
      ];
    };
  };
}
