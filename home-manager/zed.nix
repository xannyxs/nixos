{ ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
      "c"
      "cpp"
      "php"
      "javascript"
      "typescript"
    ];
    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      session = {
        trust_all_worktrees = false;
      };
      base_keymap = "Emacs";
      auto_install_extensions = {
        c = true;
        cpp = true;
        javascript = true;
        nix = true;
        php = true;
        rust = true;
        toml = true;
        typescript = true;
      };
      show_whitespaces = "all";
      theme = {
        dark = "One Dark";
        light = "Gruvbox Light";
        mode = "dark";
      };
      vim_mode = true;
      colorize_brackets = true;
      code_lens = "on";
      ui_font_size = 17;
      buffer_font_size = 18.5;
      relative_line_numbers = "enabled";
      inlay_hints = {
        enabled = true;
      };
      show_signature_help_after_edits = true;
      auto_signature_help = true;
      redact_private_values = true;
      cli_default_open_behavior = "existing_window";
      edit_predictions = {
        provider = "zed";
      };
      git = {
        inline_blame = {
          enabled = true;
        };
      };
      status_bar = {
        "experimental.show" = false;
      };
      gutter = {
        line_numbers = true;
      };
      cursor_shape = "bar";
      cursor_blink = true;
      use_system_window_tabs = true;
      buffer_font_fallbacks = [ "JetBrainsMono Nerd Font Mono" ];
      show_edit_predictions = true;
      hard_tabs = true;
      git_panel = {
        tree_view = true;
        dock = "right";
      };
      file_finder = {
        modal_max_width = "medium";
      };
      buffer_font_family = "Berkeley Mono";
      vim = { };
      which_key = {
        delay_ms = 500;
        enabled = true;
      };
      tab_bar = {
        show = true;
      };
      scrollbar = {
        show = "never";
      };
      tabs = {
        show_diagnostics = "errors";
      };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      centered_layout = {
        left_padding = 0.15;
        right_padding = 0.15;
      };
      agent = {
        default_profile = "write";
        dock = "left";
        inline_assistant_model = {
          provider = "ollama";
          model = "gpt-oss:120b-cloud";
        };
        default_model = {
          provider = "opencode";
          model = "free/minimax-m2.5-free";
        };
        favorite_models = [
          {
            provider = "opencode";
            model = "go/minimax-m2.7";
            enable_thinking = false;
          }
          {
            provider = "opencode";
            model = "go/glm-5.1";
            enable_thinking = false;
          }
          {
            provider = "CrofAI";
            model = "kimi-k2.6";
            enable_thinking = false;
          }
          {
            provider = "CrofAI";
            model = "glm-5.1";
            enable_thinking = false;
          }
          {
            provider = "CrofAI";
            model = "deepseek-v4-pro";
            enable_thinking = false;
          }
          {
            provider = "opencode";
            model = "go/kimi-k2.6";
            enable_thinking = false;
          }
        ];
      };
      language_models = {
        opencode = {
          show_zen_models = false;
        };
        ollama = {
          api_url = "http://localhost:11434";
        };
      };
      lsp = {
        tailwindcss-language-server = {
          settings = {
            classAttributes = [
              "class"
              "className"
              "ngClass"
              "styles"
            ];
          };
        };
      };
      languages = {
        TypeScript = {
          show_whitespaces = "all";
          show_edit_predictions = true;
          hard_tabs = true;
          inlay_hints = {
            enabled = true;
            show_parameter_hints = false;
            show_other_hints = true;
            show_type_hints = true;
          };
        };
        Python = {
          show_whitespaces = "all";
          show_edit_predictions = true;
          hard_tabs = true;
          format_on_save = "on";
          formatter = {
            language_server = {
              name = "ruff";
            };
          };
          language_servers = [
            "ty"
            "ruff"
            "!basedpyright"
            "!pyrefly"
            "!pyright"
            "!pylsp"
          ];
        };
      };
      terminal = {
        show_count_badge = true;
        font_size = 17.0;
        font_family = "Berkeley Mono";
        env = {
          EDITOR = "zed --wait";
        };
      };
      file_types = {
        Dockerfile = [
          "Dockerfile"
          "Dockerfile.*"
        ];
        JSON = [
          "json"
          "jsonc"
          "*.code-snippets"
        ];
      };
      file_scan_exclusions = [
        "**/.git"
        "**/.svn"
        "**/.hg"
        "**/CVS"
        "**/.DS_Store"
        "**/Thumbs.db"
        "**/.classpath"
        "**/.settings"
        "**/out"
        "**/dist"
        "**/.husky"
        "**/.turbo"
        "**/.vscode-test"
        "**/.vscode"
        "**/.next"
        "**/.storybook"
        "**/.tap"
        "**/.nyc_output"
        "**/report"
        "**/node_modules"
      ];
      project_panel = {
        auto_fold_dirs = false;
        button = true;
        dock = "right";
        git_status = true;
      };
      outline_panel = {
        dock = "right";
      };
      collaboration_panel = {
        dock = "right";
      };
      context_servers = {
        react-grab-mcp = {
          command = "npx";
          args = [
            "-y"
            "@react-grab/mcp"
            "--stdio"
          ];
          env = { };
        };
      };
    };
  };
}
