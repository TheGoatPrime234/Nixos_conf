# bundle
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/boot.nix
    ./../../modules/dbus.nix
    ./../../modules/git.nix
    ./../../modules/geistmono.nix
    ./../../modules/nixvim.nix
    ./../../modules/sl.nix
    ./../../modules/yazi.nix
    ./../../modules/zen-browser.nix
    ./../../modules/kitty.nix
    ./../../modules/zsh.nix
    ./../../modules/psmisc.nix
    ./../../modules/ssh.nix
    ./../../modules/colmena.nix
  ];

  config = {
    xanterella = {
      boot.enable = true;
      dbus.enable = true;
      git.enable = true;
      geistmono.enable = true;
      nixvim.enable = true;
      sl.enable = true;
      yazi.enable = true;
      zen-browser.enable = true;
      kitty.enable = true;
      zsh.enable = true;
      psmisc.enable = true;
      ssh.enable = true;
      colmena.enable = true;
    };
  };
}
