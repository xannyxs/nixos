{ pkgs, ... }:
{
  # Enable GNOME

  services.xserver.enable = true;
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
  displayManager.gdm.enable = true;

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xset}/bin/xset s off
    ${pkgs.xorg.xset}/bin/xset -dpms
  '';

  # Trackpad support
  services.libinput.enable = true;

  # Remove decorations for QT applications
  environment.sessionVariables = {
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  # Excluding some GNOME applications from the default install
  environment.gnome.excludePackages =
    (with pkgs; [
      gedit
      gnome-connections
      gnome-console
      gnome-photos
      gnome-tour
      snapshot
      atomix # puzzle game
      epiphany # web browser
      geary # email reader
      gnome-terminal
      tali # poker game
      yelp # help viewer
      hitori # sudoku game
      iagno # go game
    ])
    ++ (with pkgs; [
      cheese # webcam tool
      evince # document viewer
      gnome-calendar
      gnome-characters
      gnome-contacts
      gnome-disk-utility
      gnome-logs
      gnome-maps
      gnome-music
      gnome-shell-extensions
      gnome-system-monitor
      gnome-weather
      simple-scan
    ]);

  # List of Gnome specific packages
  environment.systemPackages = with pkgs; [
    gnome-clocks
    gparted
    gnome-font-viewer
    baobab # disk usage analyzer
    gnome-tweaks
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.user-themes
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.battery-health-charging
  ];
}
