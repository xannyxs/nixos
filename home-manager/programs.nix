{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      llvm-vs-code-extensions.vscode-clangd
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  home = {
    packages = with pkgs; [
      # GUI
      brave
      telegram-desktop
      librewolf-bin
      obs-studio
      protonvpn-gui
      galculator
      qalculate-gtk

      trezor-suite

      # Entertainment
      vlc
      strawberry
      calibre
      # stremio

      # Tor
      tor-browser
      qbittorrent

      # File Sharing
      localsend
      rclone

      # TUI
      tigervnc
      moreutils
      gnome-disk-utility
      astroterm
      tree

      # Programming
      rpi-imager
      htop
      distrobox
      vscodium

      jetbrains.clion

      android-studio
      android-tools
      android-udev-rules

      # Games
      ckan

      libimobiledevice
      ifuse
      exiftool

    ];
  };
}
