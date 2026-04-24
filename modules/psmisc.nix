{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.psmisc.enable = lib.mkEnableOption "Aktiviert psmisc";
  };

  config = lib.mkIf config.xanterella.psmisc.enable {
    environment.systemPackages = with pkgs; [
    psmisc
    ];
  };
}
