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
      };
    };
  };

  config = lib.mkIf (cfg.enable && nodeCfg.enable) {
    services = {
      vaultwarden = {
        enable = true;
        package = pkgs-unstable.vaultwarden;
        config = {
          WEBSOCKET_ENABLED = true;
          ROCKET_ADDRESS = "0.0.0.0";
          ROCKET_PORT = 8222;
        };
      };
    };
  };
}
