{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.bluetooth.enable = lib.mkEnableOption "Aktiviert bluetooth";
  };

  config = lib.mkIf config.xanterella.bluetooth.enable {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          general = {
            FastConnectable = "true";
          };
        };
      };
    };
    services = {
      blueman = {
        enable = true;
      };
    };
  };
}
