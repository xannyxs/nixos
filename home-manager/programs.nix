{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
  programs.starship.enable = true;

  home.packages = with pkgs; [
    zed-editor

    # CLI
    bc
    dig
    htop
    jq
    moreutils
    tree

    # Browsers
    brave
    librewolf
    tor-browser

    # Media
    obs-studio
    strawberry
    vlc

    # Messaging
    telegram-desktop

    # Networking
    filezilla
    localsend
    openvpn
    proton-vpn-cli
    qbittorrent
    rclone
    tigervnc

    # Photos & Graphics
    exiftool
    gimp
    libjxl
    libraw
    rawtherapee

    # Development
    claude-code
    devenv

    # Mobile
    ifuse
    libimobiledevice

    # Misc
    astroterm
    qalculate-gtk

    rpi-imager
    gparted
    calibre

    # Games
    ckan

    cloc
    mpv
    irssi

    btop
    deadbeef
  ];
}
