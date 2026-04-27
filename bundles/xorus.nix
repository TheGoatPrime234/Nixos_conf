{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../hosts/xorus/configuration.nix
    ./../hosts/xorus/hardware-configuration.nix
    ./../modules/local.nix
    ./modules/essentials.nix
    ./modules/nixedit.nix
    ./modules/laptop.nix
    ./../modules/audio.nix
    ./../modules/bluetooth.nix
    ./../modules/btop.nix
    ./../modules/direnv.nix
    ./../modules/tailscale.nix
    ./../modules/tree.nix
    ./../modules/wget.nix
    ./../modules/zip.nix
    ./../modules/yazi.nix
  ];

  config = {
    xanterella = {
      local.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
      btop.enable = true;
      direnv.enable = true;
      tailscale.enable = true;
      tree.enable = true;
      wget.enable = true;
      zip.enable = true;
      yazi.enable = true;
    };
  };
}
