{
  pkgs,
  userConfig,
  ...
}:

let
  custom-stremio = pkgs.callPackage ./stremio.nix { };
in
{
  imports = [
    ./git.nix
    ./lazygit.nix
    ./nvim.nix
    ./tmux.nix
    ./zsh.nix
    ./programs.nix
    ./xfce.nix
    ./gtk.nix
    # ./spicetify.nix
  ];

  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Berkeley Mono" ];
    };
  };

  # catppuccin = {
  #   flavor = "macchiato";
  #   accent = "lavender";
  # };

  home = {
    username = "${userConfig.name}";
    homeDirectory = "/home/${userConfig.name}";
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code

      custom-stremio

      ripgrep
      starship
      delta
      sbctl
      figlet
      oh-my-zsh
      zsh

      wget
      curl
      zip
      unzip
      fastfetch # System fetcher

      # Rust
      rustc
      cargo

      # Kotlin
      kotlin
      maven

      # Front - end
      nodePackages."@nestjs/cli"

      # C / C++
      gcc
      gnumake
      cmake
      nasm

      # Python
      python3
      pipenv

      # PHP
      php
      intelephense
      php84Packages.php-cs-fixer

      nodejs_22
      yarn
      typescript

      # Programs
      libreoffice
      wireshark
      ffmpeg
    ];
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  home.sessionVariables = {
  };

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
