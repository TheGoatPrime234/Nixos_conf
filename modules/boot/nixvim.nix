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
        {
          mode = ["n"];
          key = "<C-n>";
          action = "<cmd>Neotree toggle<CR>";
          options.desc = "Toggle Neo-Tree";
        }
        {
          key = "<S-h>";
          action = "<cmd>bprevious<CR>";
          options.desc = "Vorheriger Tab";
        }
        {
          key = "<S-l>";
          action = "<cmd>bnext<CR>";
          options.desc = "Nächster Tab";
        }
        {
          key = "<leader>x";
          action = "<cmd>bdelete<CR>";
          options.desc = "Aktuellen Tab schließen";
        }
      ];

      colorschemes.catppuccin.enable = true;
      colorschemes.catppuccin.autoLoad = true;

      plugins = {
        lualine.enable = true;
        treesitter.enable = true;
        neo-tree.enable = true;
        bufferline.enable = true;
        telescope = {
          enable = true;
          keymaps = {
            "<leader>p" = "finde_files";
            "<leader>g" = "live_grep";
          };
        };
      };
    };
  };
}
