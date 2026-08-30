{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      sqlmap = {
        enable = lib.mkEnableOption "Aktiviert sqlmap";
      };
    };
  };

  config = lib.mkIf config.xanterella.sqlmap.enable {
    environment = {
      systemPackages = with pkgs; [
        sqlmap
      ];
    };
  };
}
