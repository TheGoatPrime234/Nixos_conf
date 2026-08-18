{
  config,
  pkgs,
  lib,
  pkgs-unstable,
  ...
}: let
  cfg = config.xanterella.vaultwarden;
  nodeCfg = config.xanterella.cluster-node;
in {
  options = {
    xanterella = {
      vaultwarden = {
        enable = lib.mkEnableOption "Aktiviert Vaultwarden ohne externes Speichermedium";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "${nodeCfg.domain}:1003";
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    services = {
      vaultwarden = {
        enable = true;
        package = pkgs-unstable.vaultwarden;
        config = {
          DOMAIN = "https://${cfg.domain}";
          WEBSOCKET_ENABLED = true;
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;
        };
      };
      caddy = {
        virtualHosts = {
          "https://${cfg.domain}" = {
            extraConfig = ''
              reverse_proxy 127.0.0.1:8222
            '';
          };
        };
      };
    };
  };
}
