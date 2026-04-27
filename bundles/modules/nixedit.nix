# bundle
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/alejandra.nix
    ./../../scripts/restituo.nix
  ];

  config = {
    xanterella = {
      alejandra.enable = true;
      restituo.enable = true;
    };
  };
}
