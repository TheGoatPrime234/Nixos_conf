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
    displayManager = {
      sddm = {
        enable = true;
        theme = "pixie";
        autoNumlock = true;
        wayland = {
          enable = true;
        };
      };
      defaultSession = "hyprland";
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
    };
    blueman = {
      enable = true;
    };
    tailscale = {
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
