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
  services.geoclue2.enable = true;
  programs.fish.enable = true;
  services.fwupd.enable = true;

  programs.thunar.enable = true; # File manage
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; 
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  environment.systemPackages = with pkgs; [
    (symlinkJoin {
      name = "thunar";
      paths = [ xfce.thunar ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
      wrapProgram $out/bin/thunar \
      --set GTK_THEME "catppuccin-macchiato-teal-standard" \
      --set GTK_ICON_THEME "Colloid-teal"
      '';
    })

    xarchiver

    poweralertd
    playerctl
    psmisc #- A set of some small useful utilities that use the proc filesystem
    grim # - Screenshot utility for Wayland
    slurp # - Select a region in Wayland compositors
    imagemagick # - Create, edit, compose, or convert digital images
    swappy # - A Wayland native snapshot editing tool
    wl-screenrec # - Wayland screencast recorder
    wl-clipboard # - Command-line copy/paste utilities for Wayland
    wl-clip-persist # - Keep Wayland clipboard content after closing the application
    cliphist # - Wayland clipboard manager
    # wtype - xdotool type for wayland
    wlrctl # - Utility to control some of wlroots-based compositors waybar
    ffmpeg_7-full # - Complete solution to record, convert and stream audio and video
    xdg-utils # - Tools to assist applications with various desktop integration tasks
    rofi-wayland
    networkmanagerapplet
    waybar
    mako
    rofi-wayland
    kitty
    avizo
    wlogout
    telegram-desktop
    stow
    quickemu # VM Launcher
    spice # VM Network
    qemu
    niv
    # gifsicle
  ];
}
