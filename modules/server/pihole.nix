{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.pihole.enable = lib.mkEnableOption "Aktiviert pihole";
  };

  config = lib.mkIf config.xanterella.pihole.enable {
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
