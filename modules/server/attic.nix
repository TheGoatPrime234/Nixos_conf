{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      attic = {
        enable = lib.mkEnableOption "Aktiviert Attic für Caching";
      };
    };
  };

  config = lib.mkIf config.xanterella.attic.enable {
    services = {
      atticd = {
        enable = true;
        environmentFile = "/root/secrets/atticd.env";
        settings = {
          listen = "127.0.0.1:6000";
          database = {
            url = "sqlite:///var/lib/atticd/server/.db?mode=rwc";
          };
          storage = {
            type = "local";
            path = "/var/lib/atticd/storage";
          };
          chunking = {
            "nar-size-threshold" = 65536;
            "min-size" = 16384;
            "avg-size" = 65536;
            "max-size" = 262144;
          };
        };
      };
    };
    environment = {
      systemPackages = with pkgs; [
        openssl
      ];
    };
  };
}
