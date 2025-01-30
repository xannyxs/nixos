{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "xannyx";
  home.homeDirectory = "/home/xannyx";

  home.packages = with pkgs; [
    ripgrep
    starship
    bat
    delta
    lazygit
    python3
    sbctl
    figlet
    zsh
    oh-my-zsh

    wget
    curl
    zip
    unzip
    fastfetch # System fetcher

    # Rust
    rustc
    cargo

    # Lua
    lua
    stylua
    luarocks
    lua-language-server
    luajitPackages.jsregexp

    # Front - end
    nodePackages."@nestjs/cli"

    # C / C++
    gcc
    gnumake
    cmake
    nasm

    # Python
    python3

    nodejs_20
    yarn
    typescript

    # LSP
    biome
    nixfmt-rfc-style
    rustywind
    nil

    nodePackages.prettier
    nodePackages."@astrojs/language-server"
    nodePackages.ts-node
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages."@tailwindcss/language-server"
    nodePackages.vscode-json-languageserver

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.zsh = {
    enable = true;

  };

  oh-my-zsh = {
    enable = true;
    plugins = [ ];
    theme = "agnoster";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      g = "git";
      config = "git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      cl = "clear";
      lgit = "lazygit";
      ldocker = "lazydocker";
      conf = "z ~/.config";
      nixos = "z /etc/nixos";
      store = "z /nix/store";
      nswitch = "sudo nixos-rebuild switch --flake /etc/nixos";
      nswitchu = "sudo nixos-rebuild switch --flake /etc/nixos#xannyx --update-input nixpkgs --commit-lock-file --upgrade";
      nau = "sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos";
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
      fishconfig = "nvim ~/.config/fish/config.fish";
      ohmyfish = "nvim ~/.config/fish/functions";
      cat = "bat";
      rm = "rm -i";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      ll = "ls -lh";
      la = "ls -lah";
      ports = "netstat -tulanp";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      venv = "python3 -m venv ./venv";
      activate = "source ./venv/bin/activate.fish";
      dps = "docker ps";
      dimg = "docker images";
      ni = "npm install";
      nid = "npm install --save-dev";
      nig = "npm install -g";
      ns = "npm start";
      nt = "npm test";
      reload = "source ~/.config/fish/config.fish";
    };
    functions = {
      # Git functions equivalent to Oh My Zsh aliases
      ga = "git add $argv";
      gaa = "git add --all";
      gapa = "git add --patch";
      gau = "git add --update";
      gav = "git add --verbose";
      gap = "git apply";
      gb = "git branch $argv";
      gba = "git branch -a";
      gbd = "git branch -d $argv";
      gbD = "git branch -D $argv";
      gbl = "git blame -b -w";
      gbnm = "git branch --no-merged";
      gbr = "git branch --remote";
      gbs = "git bisect";
      gbsb = "git bisect bad";
      gbsg = "git bisect good";
      gbsr = "git bisect reset";
      gbss = "git bisect start";
      gc = "git commit -v";
      "gc!" = "git commit -v --amend";
      "gcn!" = "git commit -v --no-edit --amend";
      gca = "git commit -v -a";
      "gca!" = "git commit -v -a --amend";
      "gcan!" = "git commit -v -a --no-edit --amend";
      "gcans!" = "git commit -v -a -s --no-edit --amend";
      gcam = "git commit -a -m";
      gcsm = "git commit -s -m";
      gcb = "git checkout -b";
      gcf = "git config --list";
      gcl = "git clone --recurse-submodules";
      gclean = "git clean -id";
      gpristine = "git reset --hard; and git clean -dffx";
      gcm = "git checkout main";
      gcd = "git checkout develop";
      gcmsg = "git commit -m";
      gco = "git checkout";
      gcount = "git shortlog -sn";
      gcp = "git cherry-pick";
      gcpa = "git cherry-pick --abort";
      gcpc = "git cherry-pick --continue";
      gcs = "git commit -S";
      gd = "git diff";
      gdca = "git diff --cached";
      gdcw = "git diff --cached --word-diff";
      gdct = "git describe --tags (git rev-list --tags --max-count=1)";
      gds = "git diff --staged";
      gdt = "git diff-tree --no-commit-id --name-only -r";
      gdw = "git diff --word-diff";
      gf = "git fetch";
      gfa = "git fetch --all --prune";
      gfo = "git fetch origin";
      gg = "git gui citool";
      gga = "git gui citool --amend";
      ggpull = "git pull origin (git_current_branch)";
      ggpush = "git push origin (git_current_branch)";
      ggsup = "git branch --set-upstream-to=origin/(git_current_branch)";
      gpsup = "git push --set-upstream origin (git_current_branch)";
      ghh = "git help";
      gignore = "git update-index --assume-unchanged";
      gignored = "git ls-files -v | grep '^[[:lower:]]'";
      gl = "git pull";
      glg = "git log --stat";
      glgp = "git log --stat -p";
      glgg = "git log --graph";
      glgga = "git log --graph --decorate --all";
      glgm = "git log --graph --max-count=10";
      glo = "git log --oneline --decorate";
      glol = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
      glols = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat";
      glod = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'";
      glods = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short";
      glola = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all";
      glog = "git log --oneline --decorate --graph";
      gloga = "git log --oneline --decorate --graph --all";
      gm = "git merge";
      gmom = "git merge origin/main";
      gmt = "git mergetool --no-prompt";
      gmtvim = "git mergetool --no-prompt --tool=vimdiff";
      gmum = "git merge upstream/main";
      gma = "git merge --abort";
      gp = "git push";
      gpd = "git push --dry-run";
      gpf = "git push --force-with-lease";
      "gpf!" = "git push --force";
      gpoat = "git push origin --all; and git push origin --tags";
      gpu = "git push upstream";
      gpv = "git push -v";
      gr = "git remote";
      gra = "git remote add";
      grb = "git rebase";
      grba = "git rebase --abort";
      grbc = "git rebase --continue";
      grbd = "git rebase develop";
      grbi = "git rebase -i";
      grbm = "git rebase main";
      grbs = "git rebase --skip";
      grev = "git revert";
      grh = "git reset";
      grhh = "git reset --hard";
      groh = "git reset origin/(git_current_branch) --hard";
      grm = "git rm";
      grmc = "git rm --cached";
      grmv = "git remote rename";
      grrm = "git remote remove";
      grs = "git restore";
      grset = "git remote set-url";
      grss = "git restore --source";
      grt = "cd (git rev-parse --show-toplevel; or echo .)";
      gru = "git reset --";
      grup = "git remote update";
      grv = "git remote -v";
      gsb = "git status -sb";
      gsd = "git svn dcommit";
      gsh = "git show";
      gsi = "git submodule init";
      gsps = "git show --pretty=short --show-signature";
      gsr = "git svn rebase";
      gss = "git status -s";
      gst = "git status";
      gsta = "git stash push";
      gstaa = "git stash apply";
      gstc = "git stash clear";
      gstd = "git stash drop";
      gstl = "git stash list";
      gstp = "git stash pop";
      gsts = "git stash show --text";
      gstu = "git stash --include-untracked";
      gstall = "git stash --all";
      gsu = "git submodule update";
      gsw = "git switch";
      gswc = "git switch -c";
      gts = "git tag -s";
      gtv = "git tag | sort -V";
      gunignore = "git update-index --no-assume-unchanged";
      gunwip = "git log -n 1 | grep -q -c '--wip--'; and git reset HEAD~1";
      gup = "git pull --rebase";
      gupv = "git pull --rebase -v";
      gupa = "git pull --rebase --autostash";
      gupav = "git pull --rebase --autostash -v";
      glum = "git pull upstream main";
      gwch = "git whatchanged -p --abbrev-commit --pretty=medium";
      gwip = "git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m '--wip-- [skip ci]'";

      fish_command_not_found = ''
        __fish_default_command_not_found_handler $argv[1]
      '';

      podpurge = ''
        echo "Starting Podman purge..."

        # Stop and remove all containers
        echo "Stopping and removing all containers..."
        podman stop -a
        podman rm -af

        # Remove all pods
        echo "Removing all pods..."
        podman pod rm -af

        # Remove all images
        echo "Removing all images..."
        podman rmi -af

        # Remove all volumes
        echo "Removing all volumes..."
        podman volume rm -af

        # Remove all networks (except predefined ones)
        echo "Removing all custom networks..."
        podman network prune -f

        # Clean up Podman system
        echo "Cleaning up Podman system..."
        podman system prune -af

        echo "Podman purge complete."
      '';

      fish_greeting = ''
        set_color blue; echo " Distro:  NixOS"
        set_color white; echo " Langs:   Rust  JS 󰛦 TS  Lua  C"
        set_color green; echo " Shell:  󰈺 Fish"
        set_color yellow; echo "󰟶 Mood:   👨‍💻"
        set_color cyan; figlet random -f binary
      '';

      mkcd = ''
        mkdir -p $argv[1] && cd $argv[1]
      '';
    };

    shellInit = ''
      # Z Plugin Configuration
      set -U Z_CMD "j"
      set -U Z_DATA "$HOME/.z"

      # Path
      set -gx PATH $HOME/bin /usr/local/bin $HOME/.local/bin $PATH

      # Colorful man pages
      set -gx LESS_TERMCAP_md (printf "\e[01;31m")
      set -gx LESS_TERMCAP_me (printf "\e[0m")
      set -gx LESS_TERMCAP_se (printf "\e[0m")
      set -gx LESS_TERMCAP_so (printf "\e[01;44;33m")
      set -gx LESS_TERMCAP_ue (printf "\e[0m")
      set -gx LESS_TERMCAP_us (printf "\e[01;32m")

      # Starship prompt
      starship init fish | source
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
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/xannyx/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
