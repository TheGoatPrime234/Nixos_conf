{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/alejandra.nix
    ./../../modules/restituo.nix
  ];

  config = {
    xanterella = {
      alejandra.enable = true;
      restituo.enable = true;
    };
  };
}
