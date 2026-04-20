{
  config,
  pkgs,
  ...
}: {
  programs = {
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
