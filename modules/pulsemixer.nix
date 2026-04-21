{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.pulsemixer.enable = lib.mkEnableOption "Aktiviert pulsemixer";
  };

  config = lib.mkIf config.xanterella.pulsemixer.enable {
  environment.systemPackages = with pkgs; [
  pulsemixer
  ];
  };
}
