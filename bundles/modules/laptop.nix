# bundle
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/upower.nix
  ];

  config = {
    xanterella = {
      upower.enable = true;
    };
  };
}
