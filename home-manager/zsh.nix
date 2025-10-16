{ ... }:

{
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
      lgit = "lazygit";
      nixos = "cd /etc/nixos";

      nvim = "nvim";
      n = "nvim";
      nvimm = "nvim";
      nvimmm = "nvim";
      vimm = "nvim";
      vim = "nvim";

      rm = "rm -i";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
    };

    initContent = ''
      # Create completion directory with correct permissions
      if [ ! -d "$HOME/.cache/oh-my-zsh/completions" ]; then
        mkdir -p "$HOME/.cache/oh-my-zsh/completions"
        chmod 755 "$HOME/.cache/oh-my-zsh/completions" chmod 755 "$HOME/.cache/oh-my-zsh/completions/_docker"
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
}
