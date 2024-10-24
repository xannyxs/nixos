{ pkgs, ... }:

{
  # Enable Theme
  environment.variables.GTK_THEME = "catppuccin-macchiato-teal-standard";
  environment.variables.ICON_THEME = "Colloid-teal-dark";
  environment.variables.XCURSOR_THEME = "Catppuccin-Macchiato-Teal";
  environment.variables.XCURSOR_SIZE = "24";
  environment.variables.HYPRCURSOR_THEME = "Catppuccin-Macchiato-Teal";
  environment.variables.HYPRCURSOR_SIZE = "24";

  qt.enable = true;
  qt.platformTheme = "qt5ct";
  # qt.style.name = "adwaita-dark";
  qt.style = "kvantum";

  environment.pathsToLink = [
    "/share/icons"
    "/share/pixmaps"
  ];

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: {
    colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = ["teal"]; };
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = [ "teal" ]; # You can specify multiple accents here to output multiple themes 
      size = "standard";
      variant = "macchiato";
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    numix-icon-theme-circle
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
    catppuccin-cursors.macchiatoTeal
  ];
}
