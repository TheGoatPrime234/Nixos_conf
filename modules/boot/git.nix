{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.git.enable = lib.mkEnableOption "Aktiviert git und nützliche git tools";
  };

  config = lib.mkIf config.xanterella.git.enable {
    environment.systemPackages = with pkgs; [
      git
      lazygit
      gh
      git-lfs
    ];
    programs = {
      git = {
        enable = true;
        config = {
          init = {
            defaultBranch = "main";
          };
        };
      };
    };
  };
}
