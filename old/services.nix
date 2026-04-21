{
  config,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "de";
        variant = "";
      };
    };
    blueman = {
      enable = true;
    };
    syncthing = {
      enable = true;
      user = "cato";
      dataDir = "/home/cato/Documents/Vaults";
      configDir = "/home/cato/.config/syncthing";
    };
    dbus = {
      enable = true;
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
    hypridle = {
      enable = true;
    };
  };
}
