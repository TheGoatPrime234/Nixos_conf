
programs = {
    zsh = {
      enable = true;
      autosuggestions = {
        enable = true;
      };	
      syntaxHighlighting = {
        enable = true;
      };	
      autosuggestions = {
        enable = true;
      };
      enableCompletion = {
        enable = true;
      };
      enableLsColors
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
      interactiveShellinit = ''
      '';
      };
