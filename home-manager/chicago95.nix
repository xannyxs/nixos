{ pkgs, lib, ... }:
let
  chicago95 = pkgs.stdenv.mkDerivation {
    pname = "Chicago95";
    version = "3.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "grassmunk";
      repo = "Chicago95";
      rev = "master";
      sha256 = "sha256-e0X+rclCM8RCHRllvC/CBizM829dYFNByDGCsU86FqQ=";
    };
    installPhase = ''
      mkdir -p $out/share/themes
      mkdir -p $out/share/icons
      mkdir -p $out/share/sounds

      cp -r Theme/Chicago95 $out/share/themes/
      cp -r Icons/* $out/share/icons/
      cp -r Cursors/* $out/share/icons/

      if [ -d "Extras/Sounds/Chicago95" ]; then
        cp -r Extras/Sounds/Chicago95/* $out/share/sounds/Chicago95/ || true
      fi
      if [ -d "sounds/Chicago95" ]; then
        cp -r sounds/Chicago95/* $out/share/sounds/Chicago95/ || true
      fi
      if [ -d "Sounds" ]; then
        cp -r Sounds/* $out/share/sounds/Chicago95/ || true
      fi

      find $out -type l | while read link; do
        target=$(readlink -f "$link")
        if [ ! -e "$target" ]; then
          echo "Removing broken symlink: $link -> $target"
          rm "$link"
        fi
      done
    '';

    checkPhase = ''
      echo "Skipping symlink checks"
    '';

    meta = with lib; {
      description = "A Windows 95 theme for modern GTK desktops";
      homepage = "https://github.com/grassmunk/Chicago95";
      license = licenses.gpl2;
      platforms = platforms.all;
    };
  };
in
{
  chicago95 = chicago95;
}
