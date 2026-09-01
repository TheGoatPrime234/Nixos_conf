{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      burp-suite = {
        enable = lib.mkEnableOption "Aktiviert burp-suite";
      };
    };
  };

  config = lib.mkIf config.xanterella.burp-suite.enable {
    environment = {
      systemPackages = with pkgs; [
        burpsuite
      ];
    };
  };
}
