{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.wget.enable = lib.mkEnableOption "Aktiviert wget";
  };

  config = lib.mkIf config.xanterella.wget.enable {
    environment.systemPackages = with pkgs; [
      wget
    ];
  };
}
