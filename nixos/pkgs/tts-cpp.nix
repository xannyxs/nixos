{
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  SDL2,
  espeak-ng,
}:

stdenv.mkDerivation {
  pname = "tts-cpp";
  version = "0-unstable-2025-10-05";

  src = fetchFromGitHub {
    owner = "mmwillet";
    repo = "TTS.cpp";
    rev = "c04c77ab7575adf48c8af5a16e3bea179cba7dbb";
    hash = "sha256-hIvYygxIjfC2zh2pLbwZT5YDeBJH4JQJXgMF+Q3pUEA=";
    fetchSubmodules = true; # this gets the patched ggml
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    SDL2
    espeak-ng
  ];

  postPatch =
    let
      oldPath = "\${ESPEAK_LIBDIR}/espeak-ng-data";
      newPath = "${espeak-ng}/share/espeak-ng-data";
    in
    ''
      substituteInPlace CMakeLists.txt \
        --replace-fail '${oldPath}' '${newPath}'
    '';

  cmakeFlags = [
    "-DBUILD_SHARED_LIBS=OFF"
    "-DGGML_NATIVE=ON"
  ];

  # GGML must use -march=native. Nixpkgs removes it by default.
  NIX_ENFORCE_NO_NATIVE = false;

  enableParallelBuilding = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 bin/tts-cli $out/bin/tts-cli
    runHook postInstall
  '';

  meta.mainProgram = "tts-cli";
}
