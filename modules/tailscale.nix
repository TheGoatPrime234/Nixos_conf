{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.tailscale.enable = lib.mkEnableOption "Aktiviert xyy";
  };

  config = lib.mkIf config.xanterella.tailscale.enable {
    environment.systemPackages = with pkgs; [
      tailscale
    ];
    services.tailscale.enable = true;
  };
}
