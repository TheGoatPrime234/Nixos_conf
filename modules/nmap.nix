{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.nmap.enable = lib.mkEnableOption "Aktiviert nmap";
  };

  config = lib.mkIf config.xanterella.nmap.enable {
    environment.systemPackages = with pkgs; [
      nmap
    ];
  };
}
