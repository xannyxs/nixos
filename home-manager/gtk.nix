{
  pkgs,
  lib,
  ...
}:

let
  chicago95 = import ./chicago95.nix { inherit pkgs lib; };
in
{
  # Add the package to your packages
  home.packages = [ chicago95.chicago95 ];

  # Set GTK theme
  gtk = {
    enable = true;
    theme = {
      name = "Chicago95";
      package = chicago95.chicago95;
    };
    iconTheme = {
      name = "Chicago95"; # Or whichever specific icon theme you want
      package = chicago95.chicago95;
    };
  };
}
