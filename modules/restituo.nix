{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.xanterella.restituo;
  restituo = pkgs.writeShellScriptBin "restituo" ''
    set -e
    cd ~/nixos-config

    git add .
    alejandra -q *
    sudo nixos-rebuild switch --flake .#nixos -v

    if [ -z "$1" ]; then
            COMMIT_MSG="Auto-Rebuild: $(date +'%Y-%m-%d %H:%M:%S')"
    else
            COMMIT_MSG="$1"
    fi

    if git diff --cached --quiet; then
            cd ~
            echo "Rebuild erfolgreich, aber keine neuen Änderungen zum Commiten"
            notify-send "Rebuild erfolgreich, aber kein Commit"
    else
            cd ~
            git commit -m "$COMMIT_MSG"
            echo "Rebuild erfolgreich und erfolgreich committet: $COMMIT_MSG"
            notify-send "Rebuild erfolgreich: $COMMIT_MSG"
    fi
  '';
in {
  options.xanterella.restituo = {
    enable = lib.mkEnableOption "Aktiviert das Rebuild Script";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      restituo
    ];
  };
}
