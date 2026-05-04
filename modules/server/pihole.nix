{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.xyy.enable = lib.mkEnableOption "Aktiviert xyy";
  };

  config = lib.mkIf config.xanterella.xyy.enable {
    environment.systemPackages = with pkgs; [
      pihole-ftl
    ];
    services = {
      pihole-ftl = {
        enable = true;
        openFirewallDHCP = true;
        openFirewallDNS = true;
        openFirewallWebserver = true;
      };
    };
  };
}
