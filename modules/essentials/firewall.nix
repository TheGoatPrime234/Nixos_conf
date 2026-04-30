{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.firewall.enable = lib.mkEnableOption "Aktiviert firewall";
  };

  config = lib.mkIf config.xanterella.firewall.enable {
    networking = {
      nftables = {
        enable = true;
      };
      firewall = {
        enable = true;
        allowPing = true;
        trustedInterfaces = [
          "tailscale0"
        ];
        allowedTCPPorts = [
          22
          80
          443
          8384
        ];
        allowedUDPPorts = [
        ];
      };
    };
  };
}
