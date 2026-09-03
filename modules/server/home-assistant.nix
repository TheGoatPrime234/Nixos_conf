{
  config,
  pkgs-unstable,
  lib,
  inputs,
  ...
}: let
  cfg = config.xanterella.ha;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      ha = {
        enable = lib.mkEnableOption "Aktiviert Home Assisant";
      };
    };
  };
  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    virtualisation = {
      podman = {
        enable = true;
      };
      oci-containers = {
        backend = "podman";
        containers = {
          homeassistant = {
            image = "ghcr.io/home-assistant/home-assistant:stable";
            environment = {
              TZ = "Europe/Berlin";
            };
            volumes = [
              "/mnt/server-data/homeassistant:/config"
              "/etc/localtime:/etc/localtime:ro"
            ];
            extraOptions = [
              "--network=host"
            ];
            autoStart = true;
          };
        };
      };
    };
    systemd = {
      tmpfiles = {
        rules = [
          "d /mnt/server-data/homeassistant 0755 root root -"
        ];
      };
    };
  };
}
