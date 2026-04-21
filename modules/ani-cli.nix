{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.ani-cli.enable = lib.mkEnableOption "Aktiviert ani-cli";
  };

  config = lib.mkIf config.xanterella.ani-cli.enable {
    environment.systemPackages = with pkgs; [
      ani-cli
    ];
  };
}
