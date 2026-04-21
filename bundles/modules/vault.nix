{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/syncthing.nix
    ./../../modules/obsidian.nix
  ];

  config = {
    xanterella = {
      syncthing.enable = true;
      obsidian.enable = true;
    };
  };
}
