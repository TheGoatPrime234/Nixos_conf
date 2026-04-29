{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.hashcat.enable = lib.mkEnableOption "Aktiviert hashcat";
  };

  config = lib.mkIf config.xanterella.hashcat.enable {
    environment.systemPackages = with pkgs; [
      hashcat
    ];
  };
}
