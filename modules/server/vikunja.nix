{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: let
  cfg = config.xanterella.vikunja;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      vikunja = {
        enable = lib.mkEnableOption "Aktiviert Vikuna";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:2";
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    services = {
      vikunja = {
        enable = true;
        port = 8919;
        frontendScheme = "https";
        frontendHostname = "${config.networking.hostName}";
        settings = {
          service = {
            frontendurl = "https://${cfg.domain}";
          };
        };
      };
      caddy = {
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:${toString config.services.vikunja.port}
            '';
          };
        };
      };
    };
  };
}
