{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.plymouth.enable = lib.mkEnableOption "Aktiviert plymouth";
  };

  config = lib.mkIf config.xanterella.plymouth.enable {
    environment.systemPackages = with pkgs; [
    plymouth
    ];
    boot = {
      plymouth = {
        enable = true;
      };
    };
  };
}
