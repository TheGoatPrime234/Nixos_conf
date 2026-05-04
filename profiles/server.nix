{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      audiobookshelf.enable = true;
      grafana.enable = true;
      pihole.enable = true;
      syncthing.enable = true;
      vaultwarden.enable = true;
    };
  };
}
