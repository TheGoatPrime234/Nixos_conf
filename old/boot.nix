{
  config,
  pkgs,
  ...
}: {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_6_12;
    kernelParams = [
      "btusb.enable_autosuspend=0"
    ];
  };
}
