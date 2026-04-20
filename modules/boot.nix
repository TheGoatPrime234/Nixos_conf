{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.boot.enable = lib.mkEnableOption "Aktiviert Grub als bootloader";
  };

  config = lib.mkIf config.xanterella.boot.enable {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = true;
        };
        systemd-boot.enable = true;
      };
      kernelPackages = pkgs.linuxPackages_6_12;
      kernelParams = ["btusb.enable_autosuspend=0"];
    };
  };
}
