{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
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
      stress = {
        enable = true;
      };
      monitoring = {
        enable = true;
        domain = "lutik.gute-nessie.ts.net";
      };
      matrix-server = {
        enable = true;
        domain = "lutik.gute-nessie.ts.net";
      };
      attic-server = {
        enable = true;
        domain = "lutik.gute-nessie.ts.net";
      };
      vaultwarden = {
        enable = true;
        domain = "lutik.gute-nessie.ts.net";
      };
      homarr = {
        enable = true;
        domain = "lutik.gute-nessie.ts.net";
      };
      audiobookshelf = {
        enable = true;
        domain = "lutik.gute-nessie.ts.net";
      };
      netbird = {
        enable = true;
      };
    };
  };
}
