{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      audiobookshelf = {
        enable = true;
      };
      caddy = {
        enable = true;
      };
      grafana = {
        enable = true;
      };
      syncthing_server = {
        enable = true;
      };
      github-runner = {
        enable = true;
      };
      fastfetch = {
        enable = true;
      };
      btop = {
        enable = true;
      };
    };
  };
}
