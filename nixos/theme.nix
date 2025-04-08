{ pkgs, ... }:

{
  # Enable Theme
  environment.variables.XCURSOR_SIZE = "24";
  environment.variables.HYPRCURSOR_THEME = "Catppuccin-Macchiato-Teal";
  environment.variables.HYPRCURSOR_SIZE = "24";

  qt.enable = true;
  qt.platformTheme = "qt5ct";
  qt.style = "kvantum";

  # Override packages
  /*
    nixpkgs.config.packageOverrides = pkgs: {
      colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = [ "teal" ]; };
      catppuccin-gtk = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ]; # You can specify multiple accents here to output multiple themes
        size = "standard";
        variant = "macchiato";
      };
    };
  */

  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    numix-icon-theme-circle
    colloid-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
  ];
}
