{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      audiobookshelf-extern = {
        enable = true;
      };
      caddy = {
        enable = true;
      };
      grafana-extern = {
        enable = true;
      };
      pihole = {
        enable = true;
      };
      syncthing_server-extern = {
        enable = true;
      };
      fastfetch = {
        enable = true;
      };
    };
  };
}
