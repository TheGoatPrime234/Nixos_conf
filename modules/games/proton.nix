{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: {
  options = {
    xanterella = {
      proton = {
        enable = lib.mkEnableOption "Aktiviert proton";
      };
    };
  };

  config = lib.mkIf config.xanterella.proton.enable {
    environment = {
      systemPackages = with pkgs-unstable; [
        protonup-ng
      ];
    };
  };
}
