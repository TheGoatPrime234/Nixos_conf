{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      tokei = {
        enable = lib.mkEnableOption "Aktiviert tokei";
      };
    };
  };

  config = lib.mkIf config.xanterella.tokei.enable {
    environment = {
      systemPackages = with pkgs; [
        tokei
      ];
    };
  };
}
