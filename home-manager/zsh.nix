{ pkgs, ... }:
let
  zsh-patina = pkgs.rustPlatform.buildRustPackage {
    pname = "zsh-patina";
    version = "1.7.0";
    src = pkgs.fetchFromGitHub {
      owner = "michel-kraemer";
      repo = "zsh-patina";
      rev = "1.7.0";
      hash = "sha256-yhK4R3SCpkaXgxkwjHSnoU0M3enPhRO0FSxHLJ6fka4=";
    };
    cargoHash = "sha256-cv6vt3kC/dxhxoue56FePn9p38BkhuFec/W4zeRCWfM=";
  };
in
{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    shellAliases = {
      lgit = "lazygit";
      nixos = "cd /etc/nixos";
      n = "nvim";
      vim = "nvim";
      vimm = "nvim";
      rm = "rm -i";
    };

    initContent = ''
      # eval "$(${zsh-patina}/bin/zsh-patina activate)"

      # Completions
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
      zstyle ':completion:*:docker:*' option-stacking yes
      zstyle ':completion:*:docker-*:*' option-stacking yes

      # Options
      setopt AUTO_CD
      setopt PROMPT_SUBST

      # Tmux auto-attach
      if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -n "$PS1" ]; then
        exec tmux new-session -A -s main
      fi

      print_greeting() {
        echo "\033[34m Distro:  NixOS\033[0m"
        echo "\033[37m Langs:   Rust 󰛦 TS  Lua  C\033[0m"
        echo "\033[32m Shell:   Zsh\033[0m"
        echo "\033[33m 󰟶 Mood: 👨‍💻\033[0m"
        echo "\033[36m" && figlet random -f binary
      }
      print_greeting

      eval "$(starship init zsh)"
    '';
  };
}
