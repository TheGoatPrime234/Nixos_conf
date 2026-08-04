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
    };
  };
}
