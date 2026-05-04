{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.grafana.enable = lib.mkEnableOption "Aktiviert grafana";
  };

  config = lib.mkIf config.xanterella.grafana.enable {
    environment.systemPackages = with pkgs; [
      grafana
    ];
    services = {
      grafana = {
        enable = true;
      };
    };
  };
}
