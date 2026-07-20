{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      direnv = {
        enable = lib.mkEnableOption "Aktiviert direnv";
      };
    };
  };

  config = lib.mkIf config.xanterella.direnv.enable {
    programs = {
      direnv = {
        enable = true;
        silent = true;
        settings = {
          log_format = "";
        };
        nix-direnv = {
          enable = true;
        };
      };
    };
  };
}
