{
  pkgs,
  userConfig,
  ...
}:

{
  imports = [
    # ./xsession.nix
    ./git.nix
    ./lazygit.nix
    ./nvim.nix
    ./tmux.nix
    ./zsh.nix
    ./programs.nix
    ./xfce.nix
    ./gtk.nix
    ./zed.nix
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

      # custom-stremio

      ripgrep
      delta
      sbctl
      figlet
      oh-my-zsh
      zsh

      fastfetch

      # Kotlin
      kotlin
      maven

      # C / C++
      gcc
      gnumake
      cmake
      nasm

      # Python
      pipenv

      # PHP
      php
      intelephense
      php84Packages.php-cs-fixer

      nodejs_22
      yarn
      typescript

      # Programs
      onlyoffice-desktopeditors
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
  home.stateVersion = "26.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
