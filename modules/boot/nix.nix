{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      nix = {
        enable = lib.mkEnableOption "Aktiviert nix";
      };
    };
  };

  config = lib.mkIf config.xanterella.nix.enable {
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "root"
          "cato"
        ];
        auto-optimise-store = true;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
      optimise = {
        automatic = true;
      };
    };
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
  };
}
