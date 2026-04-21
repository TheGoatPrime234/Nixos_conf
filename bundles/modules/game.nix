{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/steam.nix
    ./../../modules/gamemode.nix
    ./../../modules/proton.nix
    ./../../modules/discord.nix
    ./../../modules/opengl.nix
  ];

  config = {
    xanterella = {
      steam.enable = true;
      gamemode.enable = true;
      proton.enable = true;
      discord.enable = true;
      opengl.enable = true;
    };
  };
}
