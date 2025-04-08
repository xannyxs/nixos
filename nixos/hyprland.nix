{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.variables.HYPRCURSOR_THEME = "Catppuccin-Macchiato-Teal";
  environment.variables.HYPRCURSOR_SIZE = "24";

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper

    # File manager
    nemo
    yazi

    zathura
    mpv
    imv

    # psmisc #- A set of some small useful utilities that use the proc filesystem
    grim
    slurp
    imagemagick
    swappy # - A Wayland native snapshot editing tool
    # wl-screenrec # - Wayland screencast recorder

    # Copy / Paste
    wl-clipboard
    wl-clip-persist
    cliphist

    # wtype # - xdotool type for wayland
    # wlrctl # - Utility to control some of wlroots-based compositors waybar
    xdg-utils
    rofi-wayland
    networkmanagerapplet
    waybar

    libnotify
    dunst

    avizo
    wlogout
    niv
    gifsicle
  ];
}
