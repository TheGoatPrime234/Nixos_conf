{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.git.enable = lib.mkEnableOption "Aktiviert git und nützliche git tools";
  };

  config = libmkIF config.xanterella.git.enable {
    environment.systemPackages = with pkgs; [
      git
      lazygit
      gh
      git-lfs
    ];
    programs.git = {
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "nvim";
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
      };
    };
  };
}
