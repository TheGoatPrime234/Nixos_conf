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
      attic = {
        enable = true;
        domain = "lutik.gute-nessie.ts.net";
      };
    };
  };
}
