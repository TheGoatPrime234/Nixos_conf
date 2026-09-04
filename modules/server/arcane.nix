{
  config,
  lib,
  ...
}: let
  cfg = config.xanterella.arcane-agent;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      arcane-agent = {
        enable = lib.mkEnableOption "Aktiviert Arcane Agent";
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    age = {
      secrets = {
        arcane-token = {
          file = ./. + "/../agenix/arcane-token-${config.networking.hostName}.env.age";
        };
      };
    };
    virtualisation = {
      podman = {
        dockerCompat = true;
        dockerSocket = {
          enable = true;
        };
      };
      oci-containers = {
        containers = {
          arcane-agent = {
            image = "ghcr.io/getarcaneapp/manager:v2";
            environment = {
              "AGENT_MODE" = "true";
              "MANAGER_API_URL" = "http://lacrux.gute-nessie.ts.net:3552";
              "EDGE_TRANSPORT" = "poll";
            };
            environmentFiles = [
              config.age.secrets.arcane-token.path
            ];
            volumes = [
              "/run/podman/podman.sock:/var/run/docker.sock"
            ];
            extraOptions = ["--privileged" "--network=host"];
          };
        };
      };
    };
    networking.firewall.allowedTCPPorts = [3552];
  };
}
