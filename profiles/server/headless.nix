{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    xanterella = {
      sddm = {
        enable = false;
      };
      gdm = {
        enable = false;
      };
      lightdm = {
        enable = false;
      };
    };
  };

  boot = {
    kernelParams = [
      "console=ttyS0,115200n8"
    ];
  };
}
