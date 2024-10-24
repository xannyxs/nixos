{ pkgs, ... }:

{
  # Environment variables for better font rendering
  environment.variables = {
    FREETYPE_PROPERTIES = "truetype:interpreter-version=40";
  };

  # Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      (pkgs.callPackage ./fonts/berkeley-mono.nix {})
      # (pkgs.callPackage ./fonts/helvetica.nix {})
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";  # Options: none, slight, medium, full
      };
      subpixel = {
        rgba = "rgb";  # Options: none, rgb, bgr, vrgb, vbgr
        lcdfilter = "default";  # Options: none, default, light, legacy
      };

      defaultFonts = {
        monospace = [ "Berkeley Mono" ];
        # sansSerif = [ "Helvetica" ];
      };
    };
  };
}
