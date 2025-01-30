{ pkgs, ... }:
{
  # Neovim text editor configuration
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

      # Python
      black
      pyright
      ruff
      mypy

      # -- Need to check
      shellcheck
      asm-lsp
      clang-tools

      # hadolint
      # markdownlint-cli
      # nixd
      # shfmt
    ];
  };
}
