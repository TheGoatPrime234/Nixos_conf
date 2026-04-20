{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [pkgs.zsh-powerlevel10k];
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
        restituo = "cd ~/nixos-config&&./rebuild.sh";
        gcheck = "git checkout";
      };
      interactiveShellInit = ''
               # Instant Prompt für schnelleren Start (aus deiner .zshrc) [cite: 36]
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
}
