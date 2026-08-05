{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  options = {
    xanterella = {
      bitwarden = {
        enable = lib.mkEnableOption "Aktiviert bitwarden";
      };
    };
  };

  config = lib.mkIf config.xanterella.bitwarden.enable {
    environment = {
      systemPackages = with pkgs; [
        bitwarden-desktop
      ];
    };
    nixpkgs = {
      config = {
        permittedInsecurePackages = [
          "electron-39.8.10"
        ];
      };
    };
  };
}
