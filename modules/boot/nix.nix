{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.nix.enable = lib.mkEnableOption "Aktiviert nix";
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
      };
    };
    nixpgks = {
      config = {
        allowUnfree = true;
      };
    };
  };
}
