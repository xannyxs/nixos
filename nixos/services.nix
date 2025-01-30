{ pkgs, ... }:

{
  # Enable Services
  # programs.direnv.enable = true;
  # programs.dconf.enable = true;
  # services.mpd.enable = true;
  # programs.xfconf.enable = true;

  security.polkit.enable = true;
  services.dbus.enable = true;
  services.upower.enable = true;
  services.fwupd.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true;

  programs.nix-ld.enable = true;

  # Mullvad
  networking.resolvconf.enable = false;
  services.resolved.enable = true;
  networking.wireguard.enable = true;
  networking.iproute2.enable = true;
  services.mullvad-vpn.enable = true;

  programs.zsh.enable = true;

  programs.java = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    file-roller

    libreoffice-qt
    hunspell
    hunspellDicts.nl_nl
    hunspellDicts.en_GB-ize

    # davinci-resolve-studio
    home-manager
    wireshark

    mullvad
    mullvad-vpn
    protonvpn-gui

    poweralertd
    playerctl
    # jdk21_headless
    # jdk17_headless
    jdk8

    # psmisc #- A set of some small useful utilities that use the proc filesystem
    # grim # - Screenshot utility for Wayland
    # slurp # - Select a region in Wayland compositors
    # imagemagick # - Create, edit, compose, or convert digital images
    # swappy # - A Wayland native snapshot editing tool
    # wl-screenrec # - Wayland screencast recorder
    wl-clipboard # - Command-line copy/paste utilities for Wayland
    wl-clip-persist # - Keep Wayland clipboard content after closing the application
    # cliphist # - Wayland clipboard manager
    # wtype # - xdotool type for wayland
    # wlrctl # - Utility to control some of wlroots-based compositors waybar
    ffmpeg_7-full # - Complete solution to record, convert and stream audio and video
    # xdg-utils # - Tools to assist applications with various desktop integration tasks
    # rofi-wayland
    # networkmanagerapplet
    # waybar
    # mako
    # rofi-wayland
    kitty
    avizo
    # wlogout
    quickemu # VM Launcher
    spice # VM Network
    qemu
    niv
    gifsicle
  ];
}
