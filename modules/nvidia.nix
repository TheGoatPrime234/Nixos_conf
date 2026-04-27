{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.nvidia.enable = lib.mkEnableOption "Aktiviere Nvidia Support und Nvidia Driver";
  };

  config = lib.mkIf config.xanterella.nvidia.enable {
    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
      };
      nvidia = {
        open = true;
        modesetting = {
          enable = true;
        };
        powerManagement = {
          enable = true;
        };
        prime = {
          sync = {
            enable = true;
          };
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
    services = {
      xserver = {
        enable = true;
        videoDrivers = ["nvidia"];
      };
    };
    boot = {
      kernelParams = [
        "nvidia-drm.modeset=1"
      ];
    };
    environment = {
      sessionVariables = {
        LIBVA_DRIVE_NAME = "nvidia";
        GDM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
    };
  };
}
