{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.wireshark.enable = lib.mkEnableOption "Aktiviert wireshark";
  };

  config = lib.mkIf config.xanterella.wireshark.enable {
    environment.systemPackages = with pkgs; [
      wireshark
    ];
  };
}
