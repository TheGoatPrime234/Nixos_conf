{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      gnome = {
        enable = lib.mkEnableOption "Aktiviert gnome";
      };
    };
  };

  config = lib.mkIf config.xanterella.gnome.enable {
    environment = {
      systemPackages = with pkgs; [
        gnome-tweaks
        gnome-extension-manager
      ];
      gnome = {
        excludePackages = with pkgs; [
          gnome-tour
          geary
          epiphany
        ];
      };
    };
    services = {
      gnome = {
        gcr-ssh-agent = {
          enable = false;
        };
      };
      libinput = {
        enable = true;
      };
    };
  };
}
