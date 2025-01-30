{
  pkgs,
  userConfig,
  ...
}:

{
  imports = [
    ./icons.nix
    ./bat.nix
    ./lazygit.nix
    ./nvim.nix
    # ./spicetify.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "${userConfig.name}";
  home.homeDirectory = "/home/${userConfig.name}";

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Berkeley Mono" ];
      # sansSerif = [ "Helvetica" ];
    };
  };

  catppuccin = {
    flavor = "macchiato";
    accent = "lavender";
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    ripgrep
    starship
    delta
    sbctl
    figlet
    oh-my-zsh
    zsh

    ledger-live-desktop

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
    python3Packages.requests
    python3Packages.beautifulsoup4

    nodejs_22
    yarn
    typescript
  ];

  programs.git = {
    enable = true;
    userName = "xannyx";
    userEmail = "xander@xvproductions.com";
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "z"
      ];
    };
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Aliases
    shellAliases = {
      config = "git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      lgit = "lazygit";
      conf = "cd ~/.config";
      nixos = "cd /etc/nixos";
      store = "cd /nix/store";
      nswitch = "sudo nixos-rebuild switch --flake /etc/nixos";
      nswitchu = "sudo nixos-rebuild switch --flake /etc/nixos#xannyx --update-input nixpkgs --commit-lock-file --upgrade";
      nsgc = "sudo nix-store --gc";
      ngc = "sudo nix-collect-garbage -d";
      ngc7 = "sudo nix-collect-garbage --delete-older-than 7d";
      ngc14 = "sudo nix-collect-garbage --delete-older-than 14d";
      nvim = "nvim";
      n = "nvim";
      nvimm = "nvim";
      nvimmm = "nvim";
      vimm = "nvim";
      vim = "nvim";
      cat = "bat";
      rm = "rm -i";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      venv = "python3 -m venv ./venv";
      activate = "source ./venv/bin/activate"; # Changed from .fish to regular activate
      reload = "source ~/.zshrc"; # Changed from fish config to zshrc
    };

    initExtra = ''
      # Create completion directory with correct permissions
      if [ ! -d "$HOME/.cache/oh-my-zsh/completions" ]; then
        mkdir -p "$HOME/.cache/oh-my-zsh/completions"
        chmod 755 "$HOME/.cache/oh-my-zsh/completions"
        chmod 755 "$HOME/.cache/oh-my-zsh/completions/_docker"
      fi

      dockerpurge() {
        echo "Starting Docker purge..."
        # Stop and remove all containers
        echo "Stopping and removing all containers..."
        docker stop $(docker ps -aq)
        docker rm -f $(docker ps -aq)
        # Remove all images
        echo "Removing all images..."
        docker rmi -f $(docker images -aq)
        # Remove all volumes
        echo "Removing all volumes..."
        docker volume rm -f $(docker volume ls -q)
        # Remove all networks (except predefined ones)
        echo "Removing all custom networks..."
        docker network prune -f
        # Clean up Docker system
        echo "Cleaning up Docker system..."
        docker system prune -af --volumes
        echo "Docker purge complete."
      }

      # Function: mkcd
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }

      print_greeting() {
        echo "\033[34m Distro:  NixOS\033[0m"
        echo "\033[37m Langs:   Rust 󰛦 TS  Lua  C\033[0m"
        echo "\033[32m Shell:   Zsh\033[0m"
        echo "\033[33m 󰟶 Mood: 👨‍💻\033[0m"
        echo "\033[36m" && figlet random -f binary
      }

      # Call the greeting when shell starts
      print_greeting

      eval "$(starship init zsh)"
    '';
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
