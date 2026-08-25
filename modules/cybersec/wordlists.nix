{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      wordlists = {
        enable = lib.mkEnableOption "Aktiviert wordlists";
      };
    };
  };

  config = lib.mkIf config.xanterella.wordlists.enable {
    environment = {
      systemPackages = with pkgs; [
        wordlists
        seclists
      ];
    };
  };
}
