{
  config,
  pkgs,
  lib,
  ...
}: let
cfg = config.xanterella.screenshots;
hyprscreenshot = pkgs.writeShellScriptBin "hyprscreenshot" ''
'';
in {
  options = {
    xanterella.screenshots.enable = lib.mkEnableOption "Aktiviert grim und slurp für screenshots";
  };

  config = lib.mkIf cfg.enable {
  environment.systemPackages = with pkgs; [
  grim
  slurp
  wl-clipboard
  hyprscreenshot
  ];
  };
}
