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
          };
        };
      };
    };
    powerManagement = {
      resumeCommands = ''
        sleep 2
               ${pkgs.bluez}/bin/bluetoothctl power on
      '';
    };
  };
}
