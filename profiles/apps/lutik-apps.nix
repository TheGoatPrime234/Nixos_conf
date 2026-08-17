{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      cluster-node = {
        enable = true;
        domain = "lutik.gute-nessie.ts.net";
      };
      github-runner = {
        "default_builder" = {
          url = "https://github.com/Xeravus/Xanterella-Cli";
          labels = [
            "nixos"
            "self-hosted"
            "xanterella"
          ];
        };
      };
      fastfetch = {
        enable = true;
      };
      btop = {
        enable = true;
      };
      homarr = {
        enable = true;
      };
      vikunja = {
        enable = true;
      };
      monitoring = {
        enable = true;
        domain = "lutik.gute-nessie.ts.net";
      };
      matrix-server = {
        enable = true;
      };
      attic-server = {
        enable = true;
      };
      vaultwarden = {
        enable = true;
      };
      syncthing_server = {
        enable = true;
      };
      audiobookshelf = {
        enable = true;
      };
      immich = {
        enable = true;
      };
      netbird = {
        enable = true;
      };
    };
  };
}
