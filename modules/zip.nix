{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.zip.enable = lib.mkEnableOption "Aktiviert ziptools";
  };

  config = lib.mkIf config.xanterella.zip.enable {
    environment.systemPackages = with pkgs; [
      zip
      unzip
    ];
  };
}
