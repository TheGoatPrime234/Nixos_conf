{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      bluetooth = {
        enable = lib.mkEnableOption "Aktiviert bluetooth";
      };
    };
  };

  config = lib.mkIf config.xanterella.bluetooth.enable {
    environment = {
      systemPackages = with pkgs; [
        blueman
        bluetui
      ];
    };
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            FastConnectable = "true";
            Experimental = "true";
          };
          Policy = {
            AutoEnable = "true";
          };
        };
      };
    };
    services = {
      blueman = {
        enable = false;
      };
    };
  };
}
