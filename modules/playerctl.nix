{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.audio.enable = lib.mkEnableOption "Aktiviert playerctl, pipewire, pavucontrol";
  };

  config = lib.mkIf config.xanterella.audio.enable {
    environment.systemPackages = with pkgs; [
      playerctl
      pavucontrol
      pipewire
    ];
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}
