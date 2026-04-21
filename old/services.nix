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
