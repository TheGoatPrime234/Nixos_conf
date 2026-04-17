{ config, pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions = {
        enable = true;
      };	
      syntaxHighlighting = {
        enable = true;
      };	
    };
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };	
    };
    hyprlock = {
      enable = true;
    };
    firefox = {
      enable = true;
    };
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
      };
    };
    gamemode = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };	
    };  
  };
}
