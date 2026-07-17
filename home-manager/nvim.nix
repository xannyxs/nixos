{ pkgs, ... }:
{
  home.sessionVariables.EDITOR = "nvim";

  home.packages = with pkgs; [
    neovim
    tree-sitter

    # Lua
    lua
    luarocks
    luajitPackages.jsregexp

    # LSP
    nixfmt
    rustywind
    kotlin-language-server
    ktlint
    nil

    php84Packages.composer

    vscode-langservers-extracted
    yaml-language-server
    markdownlint-cli
    markdownlint-cli2

    # Low-level
    asmfmt
    cmake-format
    shellcheck
    asm-lsp

    # Python
    black
    pyright
    ruff
    mypy

    clang-tools

    # Rust
    rustup
    lldb

    bear
  ];
}
