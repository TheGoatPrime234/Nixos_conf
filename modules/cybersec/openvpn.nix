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

  config = lib.mkIf config.xanterella.openvpn.enable {
    environment = {
      systemPackages = with pkgs; [
        openvpn
      ];
    };
    networking = {
      firewall = {
        allowedUDPPorts = [1194];
      };
    };
  };
}
