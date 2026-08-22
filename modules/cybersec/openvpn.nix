{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      openvpn = {
        enable = lib.mkEnableOption "Aktiviert openvpn";
      };
    };
  };

  config =
    lib.mkIf config.xanterella.metasploit.enable {
    };
}
