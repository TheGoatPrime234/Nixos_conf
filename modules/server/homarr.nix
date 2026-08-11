{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      homarr = {
        enable = lib.mkEnableOption "Aktiviert Homarr. Eine Homepage";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/home";
        };
      };
    };
  };
  config = lib.mkIf config.xanterella.homarr.enable {
    virtualisation = {
      oci-containers = {
        backend = "docker";
        containers = {
          homarr = {
            image = "ghcr.io/ajnart/homarr:latest";
            ports = [
              "127.0.0.1:7575:7575"
            ];
            volumes = [
              "/var/lib/homarr/configs:/app/data/configs"
              "/var/lib/homarr/icons:/app/public/icons"
              "/var/lib/homarr/data:/data"
            ];
          };
        };
      };
    };

    systemd = {
      tmpfiles = {
        rules = [
          "d /var/lib/homarr/configs 0755 root root -"
          "d /var/lib/homarr/icons 0755 root root -"
          "d /var/lib/homarr/data 0755 root root -"
        ];
      };
    };
    services = {
      tailscale = {
        permitCertUid = "caddy";
      };
      caddy = {
        enable = true;
        virtualHosts = {
          "https://${config.xanterella.homarr.domain}" = {
            extraConfig = ''
                          handle /home* {
                            reverse_proxy 127.0.0.1:7575
              }
            '';
          };
        };
      };
    };
  };
}
