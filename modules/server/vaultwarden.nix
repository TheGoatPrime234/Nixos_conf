{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.vaultwarden.enable = lib.mkEnableOption "Aktiviert vaultwarden";
  };

  config = lib.mkIf config.xanterella.vaultwarden.enable {
    environment.systemPackages = with pkgs; [
      vaultwarden
    ];
    services = {
      vaultwarden = {
        enable = true;
      };
    };
  };
}
