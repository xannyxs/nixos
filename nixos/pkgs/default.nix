final: prev: {
  llama-cpp-gfx1102 = final.callPackage ./llama-cpp-gfx1102.nix { };
  llama-swap-bin = final.callPackage ./llama-swap-bin.nix { };
  routed-gothic = final.callPackage ./routed-gothic.nix { };
  tts-cpp = final.callPackage ./tts-cpp.nix { };
}
