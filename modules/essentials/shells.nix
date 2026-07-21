{
  config,
  pkgs,
  lib,
  inputs,
  zsh-src,
  ...
}: {
  options = {
    xanterella = {
      zsh = {
        enable = lib.mkEnableOption "Aktiviert zsh";
      };
      bash = {
        enable = lib.mkEnableOption "Aktiviert Bash";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.zsh.enable {
      environment = {
        systemPackages = with pkgs; [
          zsh-powerlevel10k
          bat
        ];
      };
      users = {
        defaultUserShell = pkgs.zsh;
      };
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          enableBashCompletion = true;
          enableLsColors = true;
          autosuggestions = {
            enable = true;
          };
          setOptions = [
            "NO_NOMATCH"
          ];
          syntaxHighlighting = {
            enable = true;
          };
          shellAliases = {
            l = "ls -lha";
            cl = "clear";
            f = "fastfetch";
            v = "nvim";
            vim = "nvim";
            sv = "sudo nvim";
            za = "yazi";
            nix-pr = "nixpkgs-review pr --print-result";
          };
          interactiveShellInit = ''
                   ZSH_CACHE_DIR="$HOME/.cache/zsh"
                   if [[ ! -d "$ZSH_CACHE_DIR" ]]; then
                     mkdir -p "$ZSH_CACHE_DIR"
                   fi

                   export ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump-$HOST-$ZSH_VERSION"
            export DIRENV_LOG_FORMAT=""

                   if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
                     source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
                   fi

                   source ${inputs.p10k-src}/powerlevel10k.zsh-theme
                   [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

                   # Deine Yazi-Funktion bleibt unverändert
                   function y() {
                     local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
                     command yazi "$@" --cwd-file="$tmp"
                     IFS= read -r -d "" cwd < "$tmp"
                     [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
                     rm -f -- "$tmp"
                   }
          '';
        };
      };
      users = {
        users = {
          cato = {
            shell = pkgs.zsh;
          };
          root = {
            shell = pkgs.zsh;
          };
        };
      };
    })
    (lib.mkIf config.xanterella.bash.enable {
      programs = {
        bash = {
          completion = {
            enable = true;
          };
          shellAliases = {
            l = "ls -lha";
            cl = "clear";
            f = "fastfetch";
            v = "nvim";
            vim = "nvim";
            sv = "sudo nvim";
            za = "yazi";
            nix-pr = "nixpkgs-review pr --print-result";
          };
        };
      };
      users = {
        users = {
          cato = {
            shell = pkgs.bash;
          };
          root = {
            shell = pkgs.bash;
          };
        };
      };
    })
  ];
}
