{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.local.enable = lib.mkEnableOption "Aktiviert local";
  };

  config = lib.mkIf config.xanterella.local.enable {
    time = {
      timeZone = "Europe/Berlin";
    };
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
      };
      console.keyMap = "de";
      users = {
        users = {
          cato = {
            isNormalUser = true;
            description = "Cato";
            extraGroups = ["networkmanager" "wheel"];
          };
        };
      };
    };
    services = {
      xserver = {
        enable = true;
        xkb = {
          layout = "de";
          variant = "";
        };
      };
    };
  };
}
