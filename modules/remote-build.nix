{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.remote-build.enable = lib.mkEnableOption "Aktiviert remote-build";
  };

  config = lib.mkIf config.xanterella.remote-build.enable {
    nix = {
      buildMashines = [
        {
          hostName = "xeravus";
          system = "x86_64-linux";
          sshUser = "cato";
          maxJobs = 4;
        }
      ];
      extraOptions = ''
        builders-use-substitutes = true
      '';
      distributedBuilds = true;
      settings.max-jobs = 0;
    };
  };
}
