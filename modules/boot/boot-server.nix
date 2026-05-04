{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.boot-server.enable = lib.mkEnableOption "Aktiviert boot für ARM Server";
  };

  config = lib.mkIf config.xanterella.boot-server.enable {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = true;
        };
        systemd-boot = {
          enable = false;
        };
        grub = {
          enable = false;
        };
        generic-extlinux-compatible = {
          enable = true;
        };
      };
      kernelPackages = pkgs.linuxPackages_6_12;
      kernelParams = ["btusb.enable_autosuspend=0"];
    };
  };
}
