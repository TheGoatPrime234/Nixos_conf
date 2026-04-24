{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  options = {
    xanterella.zsh.enable = lib.mkEnableOption "Aktiviert zsh";
  };

  config = lib.mkIf config.xanterella.zsh.enable {
    environment.systemPackages = [pkgs.zsh-powerlevel10k];
    users.defaultUserShell = pkgs.zsh;
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableBashCompletion = true;
        enableLsColors = true;
        autosuggestions = {
          enable = true;
        };
        syntaxHighlighting = {
          enable = true;
        };
        shellAliases = {
          l = "ls -lha";
          cl = "clear";
          f = "fastfetch";
          v = "nvim";
          sv = "sudo nvim";
          za = "yazi";
          gcheck = "git checkout";
          nix-switcher = ".$HOME/rust_nix/nix_switcher/target/release/nix-switcher";
        };
        interactiveShellInit = ''
                 if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                   source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
                 fi
          source ${inputs.p10k-src}/powerlevel10k.zsh-theme

                 # Deine persönliche p10k Konfiguration laden
                 [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

                 # Deine Yazi-Funktion y()
                 function y() {
                   local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
                   command yazi "$@" --cwd-file="$tmp"
                   IFS= read -r -d "" cwd < "$tmp"
                   [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
                   rm -f -- "$tmp"
                 }
        '';
        ohMyZsh = {
          enable = true;
          plugins = ["git"]; # [cite: 55]
        };
      };
    };
  };
}
