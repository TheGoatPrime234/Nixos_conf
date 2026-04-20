{
  config,
  pkgs,
  ...
}: let
  wall-change = pkgs.writeShellScriptBin "wall-change" ''
    WALLPAPER_DIR="$HOME/.config/rice/wallpaper"

    RANDOM_PIC=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)
    echo "Lade: $RANDOM_PIC"
    hyprctl hyprpaper preload "$RANDOM_PIC"
    hyprctl hyprpaper wallpaper ",$RANDOM_PIC"
    hyprctl hyprpaper unload unused
  '';
in {
  environment.systemPackages = with pkgs; [
    hyprpaper
    wall-change
  ];
}
