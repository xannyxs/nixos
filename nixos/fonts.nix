{ pkgs, lib, ... }:

let
  routed-gothic = pkgs.stdenvNoCC.mkDerivation {
    pname = "routed-gothic";
    version = "1.0.0-unstable-2026-06-11";

    src = pkgs.fetchFromGitHub {
      owner = "dse";
      repo = "routed-gothic";
      rev = "365e340d64c55cb7c57940744773e6c833e3efd9";
      hash = "sha256-3CVnduEQgoxcqAajFLxX0P0jHmBTVBJRX42IyFeyfpY=";
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      install -Dm444 dist/ttf/*.ttf -t $out/share/fonts/truetype
      runHook postInstall
    '';

    meta = {
      description = "Digitization of Leroy/Gorton drafting lettering";
      homepage = "https://webonastick.com/fonts/routed-gothic/";
      license = lib.licenses.ofl;
      platforms = lib.platforms.all;
    };
  };
in
{
  # Environment variables for better font rendering
  environment.variables = {
    FREETYPE_PROPERTIES = "truetype:interpreter-version=40";
  };

  fonts = {
    fontDir.enable = true;
    packages = [
      routed-gothic
    ]
    ++ (with pkgs; [
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
    ]);

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
}
