{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../modules/alejandra.nix
    ./../modules/fastfetch.nix
    ./../modules/git.nix
    ./../modules/nixvim.nix
    ./../modules/nvidia.nix
    ./../modules/tailscale.nix
  ];

  config = {
    xanterella = {
      alejandra.enable = true;
      fastfetch.enable = true;
      git.enable = true;
      nixvim.enable = true;
      nvidia.enable = true;
      tailscale.enable = true;
    };
  };
}
