{ pkgs, ... }:
{
  # Environment variables for better font rendering
  environment.variables = {
    FREETYPE_PROPERTIES = "truetype:interpreter-version=40";
  };
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      xclip

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
      ibm-plex
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight"; # Options: none, slight, medium, full
      };
      subpixel = {
        rgba = "rgb"; # Options: none, rgb, bgr, vrgb, vbgr
        lcdfilter = "default"; # Options: none, default, light, legacy
      };
    };
  };
}
