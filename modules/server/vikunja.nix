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
    };
  };
}
