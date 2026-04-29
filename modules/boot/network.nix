{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.network.enable = lib.mkEnableOption "Aktiviert network";
  };

  config = lib.mkIf config.xanterella.network.enable {
    networking = {
      networkmanager = {
        enable = true;
      };
    };
  };
}
