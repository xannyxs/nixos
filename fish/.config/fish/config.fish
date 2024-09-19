# Fish configuration equivalent to the provided .zshrc

# .config & NixOs tracker
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias cl="clear"
alias lgit="lazygit"
alias ldocker="lazydocker"
alias conf="z ~/.config"
alias nixos="z /etc/nixos"
alias store="z /nix/store"
alias nswitch="sudo nixos-rebuild switch --flake /etc/nixos"
alias nswitchu="sudo nixos-rebuild switch --flake /etc/nixos#xannyx --update-input nixpkgs --commit-lock-file --upgrade"
alias nau="sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos"
alias nsgc="sudo nix-store --gc"
alias ngc="sudo nix-collect-garbage -d"
alias ngc7="sudo nix-collect-garbage --delete-older-than 7d"
alias ngc14="sudo nix-collect-garbage --delete-older-than 14d"

set -gx PATH $HOME/bin /usr/local/bin $PATH

# Z Plugin Configuration
set -U Z_CMD "j"
set -U Z_DATA "$HOME/.z"

# Aliases
alias nvim="nvim"
alias n="nvim"
alias nvimm="nvim"
alias nvimmm="nvim"
alias vimm="nvim"
alias vim="nvim"

alias fishconfig="nvim ~/.config/fish/config.fish"
alias ohmyfish="nvim ~/.config/fish/functions"
alias cat="bat"
alias rm="rm -i"  # Fish doesn't support aliases with spaces, so we modify this slightly

# Path
set -gx PATH $HOME/.local/bin $PATH

# pyenv
#set -gx PATH "$HOME/.pyenv/bin" $PATH
#status is-login; and pyenv init --path | source
#status is-interactive; and pyenv init - | source

# 1. Better command-not-found handling
function fish_command_not_found
    __fish_default_command_not_found_handler $argv[1]
end

# 2. Directory shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# 3. Enhanced ls commands
alias ll='ls -lh'
alias la='ls -lah'

# 5. System shortcuts
alias ports='netstat -tulanp'

# 6. Improved grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# 8. Python virtual environment handling
alias venv='python3 -m venv ./venv'
alias activate='source ./venv/bin/activate.fish'

# 9. Docker shortcuts
alias dps='docker ps'
alias dimg='docker images'

# 10. Node.js and npm shortcuts
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias ns='npm start'
alias nt='npm test'

# 12. Quick source of config
alias reload='source ~/.config/fish/config.fish'

# 13. Fish greeting (optional)
function fish_greeting
    set_color blue; echo " Distro:  NixOS"
    set_color white; echo " Langs:   Rust  JS 󰛦 TS  Lua  C"
    set_color green; echo " Shell:  󰈺 Fish"
    set_color yellow; echo "󰟶 Mood:   👨‍💻"
    set_color cyan; figlet random -f binary
end

# 14. Colorful man pages
set -gx LESS_TERMCAP_md (printf "\e[01;31m")
set -gx LESS_TERMCAP_me (printf "\e[0m")
set -gx LESS_TERMCAP_se (printf "\e[0m")
set -gx LESS_TERMCAP_so (printf "\e[01;44;33m")
set -gx LESS_TERMCAP_ue (printf "\e[0m")
set -gx LESS_TERMCAP_us (printf "\e[01;32m")

# 15. Add a custom function for creating and changing to a directory
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

starship init fish | source
