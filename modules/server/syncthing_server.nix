{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.syncthing_server.enable = lib.mkEnableOption "Aktiviert syncthing_server";
  };

  config = lib.mkIf config.xanterella.syncthing_server.enable {
    environment.systemPackages = with pkgs; [
      syncthing
    ];
    services = {
      syncthing = {
        enable = true;
        systemService = true;
      };
    };
  };
}
