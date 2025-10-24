{
  pkgs,
  stdenv,
  lib,
  ...
}:

let
  libcef = pkgs.libcef;

  cef-path = stdenv.mkDerivation {
    pname = "cef-path";
    version = libcef.version;
    dontUnpack = true;
    installPhase = ''
      mkdir -p "$out"
      find ${libcef}/lib -type f -name "*" -exec cp {} $out/ \;
      find ${libcef}/libexec -type f -name "*" -exec cp {} $out/ \;
      cp -r ${libcef}/share/cef/* $out/
      mkdir -p "$out/include"
      cp -r ${libcef}/include/* "$out/include/"
    '';
    postFixup = ''
      strip $out/*.so*
    '';
  };
in
pkgs.rustPlatform.buildRustPackage (finalAttrs: {
  pname = "stremio";
  version = "1.0.0-beta.11";

  src = pkgs.fetchFromGitHub {
    owner = "Stremio";
    repo = "stremio-linux-shell";
    tag = "v${finalAttrs.version}";
    sha256 = "sha256-FNAeur5esDqBoYlmjUO6jdi1eC83ynbLxbjH07QZ++E=";
  };

  cargoHash = "sha256-9/28BCG51jPnKXbbzzNp7KQLMkLEugFQfwszRR9kmUw=";
  nativeBuildInputs = with pkgs; [
    pkg-config
    makeWrapper
  ];

  buildFeatures = [
    "offline-build"
  ];
  buildInputs = with pkgs; [
    openssl
    gtk3
    mpv
    libcef
    libxkbcommon
  ];

  postInstall = ''
        mkdir -p $out/share/applications
        mkdir -p $out/share/icons/hicolor/scalable/apps

        mv $out/bin/stremio-linux-shell $out/bin/stremio
        cp $src/data/com.stremio.Stremio.desktop $out/share/applications/com.stremio.Stremio.desktop
        cp $src/data/icons/com.stremio.Stremio.svg $out/share/icons/hicolor/scalable/apps/com.stremio.Stremio.svg


    wrapProgram $out/bin/stremio \
       --prefix LD_LIBRARY_PATH : ${
         lib.makeLibraryPath [
           pkgs.libappindicator
           pkgs.libxkbcommon
         ]
       } \
       --prefix PATH : ${lib.makeBinPath [ pkgs.nodejs ]}
  '';

  env.CEF_PATH = cef-path;

  meta = {
    mainProgram = "stremio";
    description = "Modern media center that gives you the freedom to watch everything you want";
    homepage = "https://www.stremio.com/";
    # (Server-side) 4.x versions of the web UI are closed-source
    license = with lib.licenses; [
      gpl3Only
      # server.js is unfree
      unfree
    ];
    maintainers = with lib.maintainers; [
      griffi-gh
      { name = "nuko"; }
      { name = "xannyxs"; }
    ];
    platforms = lib.platforms.linux;
  };
})
