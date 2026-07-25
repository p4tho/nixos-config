{ ... }: {
  flake.homeModules.zed = { config, pkgs, lib, ... }: {
    programs.zed-editor = {
      enable = true;

      extensions = [
        "dockerfile"
        "html"
        "java"
        "json5"
        "kotlin"
        "lua"
        "make"
        "nim"
        "nix"
        "php"
        "sql"
        "terraform"
        "toml"
        "xml"
        "yara"
      ];

      userSettings = {
        lsp = {
          rust-analyzer = {
            binary = {
              path = lib.getExe pkgs.rust-analyzer;
              path_lookup = true;
            };
          };

          gopls = {
            binary = {
              path = lib.getExe pkgs.gopls;
              path_lookup = true;
            };
          };

          clangd = {
            binary = {
              path = lib.getExe' pkgs.clang-tools "clangd";
              path_lookup = true;
            };
          };

          # Dockerfile
          dockerfile-language-server = {
            binary = {
              path = lib.getExe pkgs.dockerfile-language-server;
              path_lookup = true;
            };
          };

          # HTML & JSON5 (VSCode Language Servers)
          vscode-html-language-server = {
            binary = {
              path = lib.getExe' pkgs.vscode-langservers-extracted "vscode-html-language-server";
              path_lookup = true;
            };
          };

          vscode-json-language-server = {
            binary = {
              path = lib.getExe' pkgs.vscode-langservers-extracted "vscode-json-language-server";
              path_lookup = true;
            };
          };

          # Java
          jdtls = {
            binary = {
              path = lib.getExe pkgs.jdt-language-server;
              path_lookup = true;
            };
          };

          # Kotlin
          kotlin-language-server = {
            binary = {
              path = lib.getExe pkgs.kotlin-language-server;
              path_lookup = true;
            };
          };

          # Lua
          lua-language-server = {
            binary = {
              path = lib.getExe pkgs.lua-language-server;
              path_lookup = true;
            };
          };

          # Nim
          nimlsp = {
            binary = {
              path = lib.getExe pkgs.nimlsp;
              path_lookup = true;
            };
          };

          # Nix
          nil = {
            binary = {
              path = lib.getExe pkgs.nil;
              path_lookup = true;
            };
          };

          # PHP
          intelephense = {
            binary = {
              path = lib.getExe pkgs.intelephense;
              path_lookup = true;
            };
          };

          # SQL
          sqls = {
            binary = {
              path = lib.getExe pkgs.sqls;
              path_lookup = true;
            };
          };

          # Terraform
          terraform-ls = {
            binary = {
              path = lib.getExe pkgs.terraform-ls;
              path_lookup = true;
            };
          };

          # TOML
          taplo = {
            binary = {
              path = lib.getExe pkgs.taplo;
              path_lookup = true;
            };
          };

          # XML
          lemminx = {
            binary = {
              path = lib.getExe pkgs.lemminx;
              path_lookup = true;
            };
          };
        };
      };
    };

    home.packages = [
      # Base utilities
      pkgs.clang-tools
      pkgs.gopls
      pkgs.rust-analyzer

      # Extension LSPs
      pkgs.dockerfile-language-server
      pkgs.intelephense
      pkgs.jdt-language-server
      pkgs.kotlin-language-server
      pkgs.lemminx
      pkgs.lua-language-server
      pkgs.nil
      pkgs.nimlsp
      pkgs.sqls
      pkgs.taplo
      pkgs.terraform-ls
      pkgs.vscode-langservers-extracted

      # Launcher wrapper
      (pkgs.writeShellScriptBin "zed" ''
        exec zeditor "$@"
      '')
    ];
  };
}
