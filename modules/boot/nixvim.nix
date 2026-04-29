{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.nixosModules.default
  ];
  options = {
    xanterella.nixvim.enable = lib.mkEnableOption "Aktiviert Nixvim";
  };

  config = lib.mkIf config.xanterella.nixvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      opts = {
        number = true;
        relativenumber = true;
        termguicolors = true;
        shiftwidth = 4;
      };
      keymaps = [
        {
          mode = ["n" "i" "v"];
          key = "<Up>";
          action = "<Nop>";
        }
        {
          mode = ["n" "i" "v"];
          key = "<Down>";
          action = "<Nop>";
        }
        {
          mode = ["n" "i" "v"];
          key = "<Left>";
          action = "<Nop>";
        }
        {
          mode = ["n" "i" "v"];
          key = "<Right>";
          action = "<Nop>";
        }
      ];

      colorschemes.catppuccin.enable = true;
      colorschemes.catppuccin.autoLoad = true;

      plugins = {
        lualine.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
