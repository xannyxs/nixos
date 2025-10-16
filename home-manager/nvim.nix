{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # Lua
      lua
      luarocks
      stylua
      lua-language-server
      luajitPackages.jsregexp

      # LSP
      biome
      nixfmt-rfc-style
      rustywind
      kotlin-language-server
      ktlint
      nil

      nodePackages.prettier
      nodePackages."@astrojs/language-server"
      nodePackages.ts-node
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages."@tailwindcss/language-server"
      nodePackages.vscode-json-languageserver
      nodePackages.bash-language-server
      vscode-langservers-extracted
      yaml-language-server
      markdownlint-cli
      markdownlint-cli2

      # Low - Level
      asmfmt
      cmake-format
      shellcheck
      asm-lsp

      # Python
      black
      pyright
      ruff
      mypy

      # -- Need to check
      clang-tools
      bear

      # -- Rust
      rustup
      cargo # Package manager and build tool
      clippy # Linter
      rustfmt # Code formatter
      lldb # Debugger

      # Just cool
      tree

      # hadolint
      # nixd
      # shfmt
    ];
  };
}
