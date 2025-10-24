{
  pkgs,
  lib,
  ...
}:

let
  chicago95 = import ./chicago95.nix { inherit pkgs lib; };
in
{
  home.packages = [ chicago95.chicago95 ];

  gtk = {
    enable = true;
    theme = {
      name = "Chicago95";
      package = chicago95.chicago95;
    };
    iconTheme = {
      name = "Chicago95";
      package = chicago95.chicago95;
    };
  };

  xdg.configFile."gtk-3.0/settings.ini".force = true;
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Chicago95
    gtk-icon-theme-name=Chicago95
    gtk-sound-theme-name=Chicago95
    gtk-enable-event-sounds=1
    gtk-enable-input-feedback-sounds=1
  '';

  xdg.configFile."gtk-4.0/settings.ini".force = true;
  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Chicago95
    gtk-icon-theme-name=Chicago95
    gtk-sound-theme-name=Chicago95
    gtk-enable-event-sounds=1
    gtk-enable-input-feedback-sounds=1
  '';
}
