{
  config,
  lib,
  ...
}: let
  cfg = config.xanterella.portainer-agent;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      portainer-agent = {
        enable = lib.mkEnableOption "Aktiviert Portainer Agent";
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    virtualisation = {
      podman = {
        dockerCompat = true;
        dockerSocket = {
          enable = true;
        };
      };
      oci-containers = {
        containers = {
          portainer-agent = {
            image = "portainer/agent:latest";
            ports = ["0.0.0.0:8999:9001"];
            volumes = [
              "/var/run/docker.sock:/var/run/docker.sock"
              "/var/lib/containers/storage:/var/lib/docker/volumes"
            ];
          };
        };
      };
    };
  };
}
