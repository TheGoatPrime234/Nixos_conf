{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.tailscale.enable = lib.mkEnableOption "Aktiviert xyy";
  };

  config = libmkIF config.xanterella.tailscale.enable {
    environment.systemPackages = with pkgs; [
      tailscale
    ];
    services.tailscale.enable = true;
    networking.firewall = {
      trustedInterface = ["tailscale0"];
      allowedUDPPorts = [41641];
    };
  };
}
