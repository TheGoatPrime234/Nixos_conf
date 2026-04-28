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
      buildMachines = [
        # <-- Korrigiert zu "buildMachines"
        {
          hostName = "192.168.178.163";
          system = "x86_64-linux";
          sshUser = "cato";
          maxJobs = 4;
<<<<<<< HEAD
          protocol = "ssh-ng"; 
          sshKey = "/root/.ssh/id_ed25519"; 
          supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
=======
          protocol = "ssh-ng"; # Schnelleres, modernes SSH-Protokoll für Nix
          sshKey = "/root/.ssh/id_ed25519"; # Wichtig für die Authentifizierung
          supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
>>>>>>> 0ca7b6b (Auto-Rebuild: 2026-04-28 19:21:26)
        }
      ];
      distributedBuilds = true;
      settings = {
<<<<<<< HEAD
        max-jobs = 0; 
=======
        max-jobs = 0; # Sorgt dafür, dass lokal gar nichts mehr gebaut wird
        builder-use-substitutes = true;
>>>>>>> 0ca7b6b (Auto-Rebuild: 2026-04-28 19:21:26)
        builders = [
          "ssh://cato@192.168.178.163 x86_64-linux - 4 1"
        ];
      };
    };
  };
}
