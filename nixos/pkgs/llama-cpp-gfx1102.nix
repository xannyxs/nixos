{
  llama-cpp,
  rocmPackages,
  fetchFromGitHub,
}:

(llama-cpp.override {
  blasSupport = true;
  vulkanSupport = false;
  rocmSupport = false;
  cudaSupport = false;
  metalSupport = false;
}).overrideAttrs
  (oldAttrs: rec {
    version = "10758";
    npmDepsHash = "sha256-2Q7XhaLAArmviOLdQsNbYTfdyDE5pW9lR26cRHEVl9k=";
    buildInputs =
      (oldAttrs.buildInputs or [ ])
      ++ (with rocmPackages; [
        clr
        hipblas
        rocblas
        rocsolver
        rocm-device-libs
        rocm-runtime
        rocminfo
        rocwmma
      ]);
    src = fetchFromGitHub {
      owner = "ggml-org";
      repo = "llama.cpp";
      tag = "b${version}";
      hash = "sha256-XVlsIrsGEx/cE4NRDrbuHznXPvNqSIFMi/fTm/QdlQY=";
      leaveDotGit = true;
      postFetch = ''
        git -C "$out" rev-parse --short HEAD > $out/COMMIT
      '';
    };
    cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
      "-DGGML_NATIVE=ON"
      "-DGGML_HIP=ON"
      "-DGGML_HIP_ROCWMMA_FATTN=ON"
      "-DGPU_TARGETS=gfx1102"
      "-DCMAKE_HIP_COMPILER=${rocmPackages.llvm.clang}/bin/clang"

      "-DLLAMA_BUILD_SERVER=ON"
      "-DLLAMA_BUILD_TESTS=OFF"
      "-DLLAMA_BUILD_EXAMPLES=OFF"
      "-DLLAMA_BUILD_UI=OFF"
      "-DLLAMA_BUILD_WEBUI=OFF"
    ];
    env = (oldAttrs.env or { }) // {
      ROCM_PATH = "${rocmPackages.clr}";
      HIP_DEVICE_LIB_PATH = "${rocmPackages.rocm-device-libs}/amdgcn/bitcode";
    };
    preConfigure = ''
      export NIX_ENFORCE_NO_NATIVE=0
      ${oldAttrs.preConfigure or ""}
    '';
  })
