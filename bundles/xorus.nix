{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./../modules/local.nix
    ./../modules/btop.nix
    ./../modules/direnv.nix
    ./../modules/ssh.nix
    ./../modules/git.nix
    ./../modules/boot.nix
    ./../modules/colmena.nix
    ./modules/hyprland.nix
  ];

  config = {
    xanterella = {
      local.enable = true;
      boot.enable = true;
      btop.enable = true;
      direnv.enable = true;
      ssh.enable = true;
      colmena.enable = true;
      git.enable = true;
    };
  };
}
