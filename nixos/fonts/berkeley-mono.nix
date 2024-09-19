{ stdenv, lib }:

stdenv.mkDerivation {
  name = "berkeley-mono";
  
  src = /home/xannyx/.local/share/fonts/BerkeleyMono;
  
  installPhase = ''
    mkdir -p $out/share/fonts/opentype $out/share/fonts/truetype
    if [ -n "$(ls $src/*.otf 2>/dev/null)" ]; then
      cp -v $src/*.otf $out/share/fonts/opentype/
    elif [ -n "$(ls $src/*.ttf 2>/dev/null)" ]; then
      cp -v $src/*.ttf $out/share/fonts/truetype/
    else
      echo "Error: No .otf or .ttf files found in $src"
      ls -l $src
      exit 1
    fi
  '';
  meta = with lib; {
    description = "Berkeley Mono font";
    license = licenses.unfree;
    platforms = platforms.all;
  };
}
