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
    virtualisation.podman.enable = true;
    virtualisation.oci-containers.backend = "podman";
    virtualisation.oci-containers.containers.pihole = {
      image = "pihole/pihole:latest";
      ports = [
        "53:53/tcp"
        "53:53/udp"
        "80:80/tcp"
      ];
      environment = {
        TZ = "Europe/Berlin";
        WEBPASSWORD = "Extremsicherespasswort";
      };
      volumes = [
        "/var/lib/pihole:/etc/pihole"
        "/var/lib/dnsmasq.d:/etc/dnsmasq.d"
      ];
    };
    networking.firewall.allowedTCPPorts = [53 80];
    networking.firewall.allowedUDPPorts = [53];
    services.resolved.enable = false;
  };
}
