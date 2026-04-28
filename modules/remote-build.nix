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
      buildMachines = [ # <-- Korrigiert zu "buildMachines"
        {
          hostName = "192.168.178.163";
          system = "x86_64-linux";
          sshUser = "cato";
          maxJobs = 4;
          protocol = "ssh-ng"; 
          sshKey = "/root/.ssh/id_ed25519"; 
          supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
        }
      ];
      distributedBuilds = true;
      settings = {
        max-jobs = 0; 
        builders = [
	  "ssh://cato@192.168.178.163 x86_64-linux - 4 1"
	];  
      };
    };
  };
}
