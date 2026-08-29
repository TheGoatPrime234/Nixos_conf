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
        head = true;
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
      };
      matrix-server = {
        enable = true;
      };
      opsbot = {
        enable = true;
      };
      attic-server = {
        enable = true;
      };
      livesync = {
        enable = true;
      };
      vaultwarden = {
        enable = true;
      };
      audiobookshelf = {
        enable = true;
      };
      immich = {
        enable = true;
        ml-domain = "swetik.gute-nessie.ts.net";
      };
      paperlessngx = {
        enable = true;
      };
      prometheus = {
        enable = true;
      };
      netbird = {
        enable = true;
      };
    };
  };
}
