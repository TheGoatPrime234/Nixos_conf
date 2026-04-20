{
  config,
  pkgs,
  lib,
  ...
}: {
imports = [
 ../alejandra.nix
 ../fastfetch.nix
 ../git.nix
 ../nixvim.nix
 ../nvidia.nix
 ../tailscale.nix
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
