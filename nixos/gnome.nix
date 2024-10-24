{
  pkgs,
  ...
}:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # Enable location services
  services.geoclue2 = {
    enable = true;
    enableWifi = true;
    appConfig = {
      "gnome-datetime-panel" = {
        isAllowed = true;
        isSystem = true;
      };
      "gnome-settings-daemon" = {
        isAllowed = true;
        isSystem = true;
      };
    };
  };
  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable touchpad support
  services.libinput.enable = true;

  # environment.gnome.excludePackages = with pkgs.gnome; [
  #   # cheese # photo booth
  #   epiphany # web browser
  #   pkgs.gedit # text editor
  #   totem # video player
  #   geary # email client
  #   # seahorse # password manager
  # ];

  # Install some GNOME applications and tools
  environment.systemPackages = with pkgs; [
    gnome-bluetooth
    gnome-tweaks
    nautilus
    geoclue2
    eog
    evince
    gnome-calculator
    gnome-calendar
    gnome-music
    gnome-photos
    gnome-system-monitor
    gnome-extensions-cli
  ];

  # Enable some GNOME services
  services.gnome = {
    gnome-keyring.enable = true;
    gnome-online-accounts.enable = true;
    gnome-settings-daemon.enable = true;
    tracker.enable = true;
    tracker-miners.enable = true;
  };

  # Enable GNOME file-sharing
  services.gvfs.enable = true;
}
