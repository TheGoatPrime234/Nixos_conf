{
  config,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "";
      };
    };
    upower = {
      enable = true;
    };
    gnome = {
      gnome-keyring = {
        enable = true;
      };
    };
    printing = {
      enable = true;
    };
    flatpak = {
      enable = true;
    };
  };
}
