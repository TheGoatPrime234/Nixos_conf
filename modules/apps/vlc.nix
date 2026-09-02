{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      vlc = {
        enable = lib.mkEnableOption "Aktiviert vlc";
      };
    };
  };

  config = lib.mkIf config.xanterella.vlc.enable {
    environment = {
      systemPackages = with pkgs; [
        vlc
      ];
    };
  };
}
