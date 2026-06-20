{
  config,
  lib,
  ...
}: {
  imports = [
    ./desktop.nix
  ];
  config = {
    xanterella = {
      gdm = {
        enable = true;
      };
      gnome = {
        enable = true;
      };
      power-profiles-daemon = {
        enable = true;
      };
    };
  };
}
