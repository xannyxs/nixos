{ pkgs, ... }:

{
  # Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      (pkgs.callPackage ./fonts/berkeley-mono.nix {})
      # (pkgs.callPackage ./fonts/helvetica.nix {})
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Berkeley Mono" ];
        # sansSerif = [ "Helvetica" ];
      };
    };
  };
}
