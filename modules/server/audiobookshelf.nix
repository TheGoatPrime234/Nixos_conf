{
  config,
  pkgs,
  lib,
  pkgs-new,
  ...
}: {
  options = {
    xanterella = {
      audiobookshelf = {
        enable = lib.mkEnableOption "Aktiviert audiobookshelf ohne externes Speichermedium";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/audiobookshelf";
        };
      };
      audiobookshelf-extern = {
        enable = lib.mkEnableOption "Aktiviert Audiobookshelf mit externem Speichermedium";
        domain = lib.mkOption {
          type = lib.types.str;
          default = "xanterella.de/audiobookshelf";
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.audiobookshelf.enable {
      services = {
        audiobookshelf = {
          enable = true;
          package = pkgs-new.audiobookshelf;
          host = "127.0.0.1";
          port = 13378;
        };

        tailscale = {
          permitCertUid = "caddy";
        };
        caddy = {
          enable = true;
          virtualHosts = {
            "https://${config.xanterella.audiobookshelf.domain}" = {
              extraConfig = ''
                   handle /audiobookshelf* {
                reverse_proxy 127.0.0.1:13378
                          }
              '';
            };
          };
        };
      };
      systemd = {
        services = {
          audiobookshelf = {
            environment = {
              ROUTER_BASE_PATH = "/audiobookshelf";
            };
          };
        };
      };
    })
    (lib.mkIf config.xanterella.audiobookshelf-extern.enable {
      fileSystems = {
        "/var/lib/audiobookshelf" = {
          device = "/mnt/server-data/nix/audiobookshelf";
          options = [
            "bind"
            "nofail"
          ];
          depends = ["/mnt/server-data"];
        };
      };
      services = {
        audiobookshelf = {
          enable = true;
          package = pkgs-new.audiobookshelf;
          host = "127.0.0.1";
          port = 13378;
        };
        tailscale = {
          permitCertUid = "caddy";
        };
        caddy = {
          enable = true;
          virtualHosts = {
            "https://${config.xanterella.audiobookshelf-extern.domain}" = {
              extraConfig = ''
                       handle /audiobookshelf* {
                                  reverse_proxy ${config.extern.services.audiobookshelf.host}:${toString config.extern.services.audiobookshelf.port} {
                	flush_interval -1
                    }

                    request_body {
                	max_size 0
                    }
                }
              '';
            };
          };
        };
      };
      systemd = {
        services = {
          audiobookshelf = {
            environment = {
              ROUTER_BASE_PATH = "/audiobookshelf";
            };
          };
        };
      };
    })
  ];
}
