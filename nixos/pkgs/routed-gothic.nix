{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "routed-gothic";
  version = "1.0.0-unstable-2026-06-11";

  src = fetchFromGitHub {
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
}
