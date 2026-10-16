{ pkgs, ... }:

{
  # Environment variables for better font rendering
  environment.variables = {
    FREETYPE_PROPERTIES = "truetype:interpreter-version=40";
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      routed-gothic

      # Sans-serif fonts
      source-sans
      open-sans
      roboto
      inter
      noto-fonts

      # Serif fonts
      source-serif
      libre-baskerville
      merriweather
      ibm-plex

      # Monospace fonts
      jetbrains-mono
      fira-code
      source-code-pro
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };
  };

  environment.systemPackages = [ pkgs.corefonts ];
}
