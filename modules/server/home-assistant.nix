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
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:1010";
        };
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
            ports = [
              "127.0.0.1:8123:8123"
            ];
            extraOptions = [
              "--network=host"
            ];
            autoStart = true;
          };
        };
      };
    };
    services = {
      caddy = {
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:8123
            '';
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
