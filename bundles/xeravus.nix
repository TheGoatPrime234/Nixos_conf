{
  config,
  pkgs,
  lib,
  ...
}: {
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
