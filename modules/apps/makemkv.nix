{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  options = {
    xanterella = {
      makemkv = {
        enable = lib.mkEnableOption "Aktiviert makemkv";
      };
    };
  };

  config = lib.mkIf config.xanterella.makemkv.enable {
    boot.kernelModules = ["sg"];
    users.users.cato.extraGroups = ["cdrom" "video"];
    environment = {
      systemPackages = with pkgs-unstable; [
        makemkv
      ];
    };
  };
}
