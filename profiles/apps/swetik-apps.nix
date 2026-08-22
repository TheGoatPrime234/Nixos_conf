{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      cluster-node = {
        enable = true;
        domain = "swetik.gute-nessie.ts.net";
      };
      fastfetch = {
        enable = true;
      };
      btop = {
        enable = true;
      };
      netbird = {
        enable = true;
      };
    };
  };
}
