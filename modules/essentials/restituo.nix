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

    git add -A
    alejandra -q *
    nix flake update nix-programs
    nh os switch . -H xeravus

    if [ -z "$1" ]; then
            COMMIT_MSG="Auto-Rebuild: $(date +'%Y-%m-%d %H:%M:%S')"
    else
            COMMIT_MSG="$1"
    fi

    if git diff --cached --quiet; then
            echo "Rebuild erfolgreich, aber keine neuen Änderungen zum Commiten"
            notify-send "Rebuild erfolgreich, aber kein Commit"
    else
            git commit -am "$COMMIT_MSG"
            echo "Rebuild erfolgreich und erfolgreich committet: $COMMIT_MSG"
            notify-send "Rebuild erfolgreich: $COMMIT_MSG"
    fi
    fastfetch
    echo ""
  '';
in {
  options.xanterella.restituo = {
    enable = lib.mkEnableOption "Aktiviert das Rebuild Script";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      restituo
      nh
    ];
    programs = {
      nh = {
        enable = true;
        flake = "/home/cato/nixos-config/";
      };
    };
  };
}
