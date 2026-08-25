{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      ffuf = {
        enable = lib.mkEnableOption "Aktiviert ffuf";
      };
    };
  };

  config = lib.mkIf config.xanterella.ffuf.enable {
    environment = {
      systemPackages = with pkgs; [
        ffuf
      ];
    };
  };
}
