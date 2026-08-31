{
pkgs-unstable,
config,
lib,
pkgs,
...
}: let
cfg = config.xanterella.jellyfin;
nodeCfg = config.xanterella.cluster-node;
in {
options = {
chanterelles = {
jellyfin = {
enalble lib.mkEnableOption "Aktiviert Jellyfin";
};
};
};
config = lib.mkIf (cfg.enable && nodeCfg.enable) {
};
}