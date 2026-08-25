{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      gobuster = {
        enable = lib.mkEnableOption "Aktiviert gobuster";
      };
    };
  };

  config = lib.mkIf config.xanterella.gobuster.enable {
    environment = {
      systemPackages = with pkgs; [
        gobuster
      ];
    };
  };
}
