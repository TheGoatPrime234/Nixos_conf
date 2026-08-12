{
  config,
  pkgs,
  lib,
  pkgs-new,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.nixosModules.default
  ];
  options = {
    xanterella = {
      nixvim = {
        enable = lib.mkEnableOption "Aktiviert Nixvim";
      };
    };
  };

  config = lib.mkIf config.xanterella.nixvim.enable {
    environment = {
      systemPackages = with pkgs; [
        ripgrep
        qt6.qtdeclarative
        kdePackages.qtdeclarative
      ];
    };
    programs = {
      nixvim = {
        enable = true;
        defaultEditor = true;
        globals = {
          mapleader = " ";
        };
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
            key = "<S-h>";
            action = "<cmd>bprevious<CR>";
            options = {
              desc = "Vorheriger Tab";
            };
          }
          {
            key = "<S-l>";
            action = "<cmd>bnext<CR>";
            options = {
              desc = "Nächster Tab";
            };
          }
          {
            key = "<leader>x";
            action = "<cmd>bdelete<CR>";
            options = {
              desc = "Aktuellen Tab schließen";
            };
          }
          {
            mode = "n";
            key = "<leader>fg";
            action = "<cmd>lua Snacks.picker.grep()<CR>";
            options = {
              desc = "Live Grep";
            };
          }
          {
            mode = "n";
            key = "<leader>fs";
            action = "<cmd>lua Snacks.picker.treesitter()<CR>";
            options = {
              desc = "Funktionen und Struktur (Outline)";
            };
          }
          {
            mode = "n";
            key = "<leader>j";
            action = "<cmd>cnext<CR>";
            options = {
              desc = "Nächster Quickfix-Eintrag";
            };
          }
          {
            mode = "n";
            key = "<leader>k";
            action = "<cmd>cprev<CR>";
            options = {
              desc = "Vorheriger Quickfix-Eintrag";
            };
          }
          {
            mode = "n";
            key = "<leader>fp";
            action = "<cmd>lua Snacks.picker.projects()<CR>";
            options = {
              desc = "Projects";
            };
          }
          {
            mode = ["n" "t"];
            key = "<leader>tt";
            action = "<cmd>lua Snacks.terminal.toggle()<CR>";
            options = {
              desc = "Terminal umschalten";
            };
          }
          {
            mode = "n";
            key = "<leader>gg";
            action = "<cmd>lua Snacks.lazygit()<CR>";
            options = {
              desc = "Lazygit öffnen";
            };
          }
          {
            mode = "n";
            key = "<leader>ff";
            action = "<cmd>lua Snacks.explorer()<CR>";
            options = {
              desc = "Explorer";
            };
          }
          {
            mode = ["n" "i"];
            key = "<C-n>";
            action = "<cmd>lua Snacks.picker.files()<CR>";
            options = {
              desc = "Find Files";
            };
          }
        ];

        #colorschemes = { catppuccin = { enable = true; autoLoad = true; }; };
        plugins = {
          lualine = {
            enable = true;
          };
          treesitter = {
            enable = true;
          };
          bufferline = {
            enable = true;
          };
          vim-be-good = {
            enable = true;
          };
          hardtime = {
            enable = true;
          };
          highlight-colors = {
            enable = true;
          };
          neogit = {
            enable = true;
          };
          gitsigns = {
            enable = true;
          };
          web-devicons = {
            enable = true;
          };
          snacks = {
            enable = true;
            settings = {
              bigfile = {
                enable = true;
              };
              notifier = {
                enable = true;
              };
              terminal = {
                enable = true;
              };
              lazygit = {
                enable = true;
              };
              quickfile = {
                enable = true;
              };
              statuscolumn = {
                enable = true;
              };
              words = {
                enable = true;
              };
              picker = {
                enable = true;
              };
              explorer = {
                enable = true;
              };
              dashboard = {
                enable = true;
                sections = [
                  {section = "header";}
                  {
                    section = "keys";
                    gap = 1;
                    padding = 1;
                  }
                  {
                    section = "recent_files";
                    icon = " ";
                    title = "Letzte Dateien";
                    indent = 2;
                    padding = 1;
                  }
                  {
                    section = "projects";
                    icon = " ";
                    title = "Projekte";
                    indent = 2;
                    padding = 1;
                  }
                ];
              };
            };
          };
          conform-nvim = {
            enable = true;
            settings = {
              format_on_save = {
                lsp_fallback = false;
                timeout_ms = 500;
              };
              formatters_by_ft = {
                qml = [
                  "qmlformat"
                ];
                nix = [
                  #"alejandra"
                ];
              };
            };
          };
          cmp = {
            enable = true;
            settings = {
              sources = [
                {name = "nvim_lsp";}
                {name = "path";}
                {name = "buffer";}
              ];
              mapping = {
                "<C-n>" = "cmp.mapping.select_next_item()";
                "<C-p>" = "cmp.mapping.select_prev_item()";
                "<S-CR>" = "cmp.mapping.confirm({ select = true })";
                "<C-Space>" = "cmp.mapping.complete()";
              };
            };
          };
          lsp = {
            enable = true;
            servers = {
              # rust_analyzer = {
              # enable = false;
              # installCargo = true;
              # installRustc = true;
              # };
            };
            keymaps = {
              lspBuf = {
                "gd" = "definition";
                "K" = "hover";
                "<leader>ca" = "code_action";
              };
            };
          };
        };
        extraPackages = with pkgs-new; [
          alejandra
        ];
      };
    };
  };
}
