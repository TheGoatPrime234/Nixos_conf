{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.xanterella.hyprpaper;
  wall-change = pkgs.writeShellScriptBin "wall-change" ''
    WALLPAPER_DIR="$HOME/.config/rice/wallpaper"
    RANDOM_PIC=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)
    if [ -z "$RANDOM_PIC" ]; then
      echo "Kein Bild gefunden in $WALLPAPER_DIR"
      exit 1
    fi
    echo "Lade: $RANDOM_PIC"
    hyprctl hyprpaper preload "$RANDOM_PIC"
    hyprctl hyprpaper wallpaper ",$RANDOM_PIC"
    hyprctl hyprpaper unload unused
  '';
in {
  options.xanterella.hyprpaper = {
    enable = lib.mkEnableOption "Aktiviert Hyprpaper und das wall-change Skript";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hyprpaper
      wall-change
    ];
  };
}
