{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    ripgrep # Quick grep
    bat # Alternative cat
    delta # Git pager
    fish
    lazygit # CLI Gui for git
    starship

    # Zsh Plugins
    # zsh-syntax-highlighting

    wget
    curl
    zip
    unzip
    fastfetch # System fetcher

    # C / C++
    gcc
    gnumake
    cmake
    nasm

    # Python
    python3

    # Rust
    rustc
    cargo


    # Lua
    lua
    luarocks
    luajit
    lua-language-server


    # upx
    # lazygit
    # license-generator
    # git-ignore
    # gitleaks
    # pass-git-helper
    # just
    # xh
    # tgpt
    # mcfly # terminal history
    # zellij
    # progress
    # noti
    # topgrade
    # rewrk
    # wrk2
    # procs
    # tealdeer
    # monolith
    # aria
    # sd
    # ouch
    # duf
    # du-dust
    # fd
    # jq
    # gh
    # trash-cli
    # zoxide
    # tokei
    # fzf
    # mdcat
    # pandoc
    # lsd
    # lsof
    # gping
    # viu
    # tre-command
    # felix-fm
    # chafa

    # Meme commands
    cmatrix
    pipes-rs
    rsclock
    cava
    figlet
    sbctl
  ];
}
