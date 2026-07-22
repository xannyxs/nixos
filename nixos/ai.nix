{ pkgs, ... }:

let
  optimizedLlamaCpp =
    (pkgs.llama-cpp.override {
      blasSupport = true;
      vulkanSupport = false;
      rocmSupport = false;
      cudaSupport = false;
      metalSupport = false;
    }).overrideAttrs
      (oldAttrs: rec {
        version = "10067";
        npmDepsHash = "sha256-6s9skw1wzEfm9QKktTqea3J+oudQAsS6O2VnZEMXAdw=";
        buildInputs =
          (oldAttrs.buildInputs or [ ])
          ++ (with pkgs.rocmPackages; [
            clr
            hipblas
            rocblas
            rocsolver
            rocm-device-libs
            rocm-runtime
            rocminfo
          ]);
        src = pkgs.fetchFromGitHub {
          owner = "ggml-org";
          repo = "llama.cpp";
          tag = "b${version}";
          hash = "sha256-qaBHLWrcMN/eVBNOwbUG7v+OZX+EOnkzRz8CQ0CB8tE=";
          leaveDotGit = true;
          postFetch = ''
            git -C "$out" rev-parse --short HEAD > $out/COMMIT
            find "$out" -name .git -print0 | xargs -0 rm -rf
          '';
        };
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
          "-DGGML_NATIVE=ON"
          "-DGGML_HIP=ON"
          "-DAMDGPU_TARGETS=gfx1102"
          "-DCMAKE_HIP_COMPILER=${pkgs.rocmPackages.llvm.clang}/bin/clang"
          "-DLLAMA_BUILD_SERVER=ON"
          "-DLLAMA_BUILD_TESTS=OFF"
          "-DLLAMA_BUILD_EXAMPLES=OFF"
        ];
        env = (oldAttrs.env or { }) // {
          ROCM_PATH = "${pkgs.rocmPackages.clr}";
          HIP_DEVICE_LIB_PATH = "${pkgs.rocmPackages.rocm-device-libs}/amdgcn/bitcode";
        };
        preConfigure = ''
          export NIX_ENFORCE_NO_NATIVE=0
          ${oldAttrs.preConfigure or ""}
        '';
      });

  models = {
    qwen-14b = pkgs.fetchurl {
      url = "https://huggingface.co/unsloth/Qwen3-14B-GGUF/resolve/main/Qwen3-14B-UD-Q3_K_XL.gguf";
      hash = "sha256-RrjIo/2j3jdPRlvkcXbJVuRMfvVs7d9qqLr92xxz1bY=";
    };
    qwen-9b = pkgs.fetchurl {
      url = "https://huggingface.co/HauhauCS/Qwen3.5-9B-Uncensored-HauhauCS-Aggressive/resolve/main/Qwen3.5-9B-Uncensored-HauhauCS-Aggressive-Q4_K_M.gguf";
      hash = "sha256-LKY22egdPSPKm2DCNP4YXTDsCC7rppzncP2wx2VZpPU=";
    };
    gemma-4b = pkgs.fetchurl {
      url = "https://huggingface.co/HauhauCS/Gemma-4-E4B-Uncensored-HauhauCS-Aggressive/resolve/main/Gemma-4-E4B-Uncensored-HauhauCS-Aggressive-Q6_K_P.gguf";
      hash = "sha256-8osK4mIVivENhHw/Ab/blDFh3TEyDzrtIHde4q1sZ6Y=";
    };
    qwen-35b = pkgs.fetchurl {
      url = "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-MTP-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
      hash = "sha256-VZg8WnWhq5aYJAd7O7PeQUboKpI0BytIrU6Pkq0/6fE=";
    };
  };

  commonFlags = "--flash-attn on --cache-type-k q8_0 --cache-type-v q8_0 --threads 10 --batch-size 512";

  llamaSwapConfig = ''
    models:
      qwen-14b:
        cmd: |
          ${optimizedLlamaCpp}/bin/llama-server -m ${models.qwen-14b} --port ''${PORT} -c 16384 ${commonFlags} -ngl 99 
      qwen-9b:
        cmd: |
          ${optimizedLlamaCpp}/bin/llama-server -m ${models.qwen-9b} --port ''${PORT} -c 32768 ${commonFlags} -ngl 99 
      gemma-4b:
        cmd: |
          ${optimizedLlamaCpp}/bin/llama-server -m ${models.gemma-4b} --port ''${PORT} -c 8192 ${commonFlags} -ngl 99 
      qwen-35b:
        cmd: |
          ${optimizedLlamaCpp}/bin/llama-server -m ${models.qwen-35b} --port ''${PORT} ${commonFlags} --n-cpu-moe 35 -c 16384 --spec-type draft-mtp --spec-draft-n-max 2 --temp 1.0 --top-p 0.95 --top-k 20 --min-p 0.0 --presence-penalty 1.5 --repeat-penalty 1.0 -np 1
  '';

  llamaSwapPkg = pkgs.runCommand "llama-swap" { buildInputs = [ pkgs.gnutar ]; } ''
    mkdir -p $out/bin
    mkdir -p temp_extract
    tar -xzf ${
      pkgs.fetchurl {
        url = "https://github.com/mostlygeek/llama-swap/releases/download/v175/llama-swap_175_linux_amd64.tar.gz";
        hash = "sha256-zeyVz0ldMxV4HKK+u5TtAozfRI6IJmeBo92IJTgkGrQ=";
      }
    } -C temp_extract
    find temp_extract -type f -name "llama-swap" -exec cp {} $out/bin/ \;
    chmod +x $out/bin/llama-swap
  '';
in
{
  services.librechat = {
    enable = true;
    enableLocalDB = true;
    meilisearch.enable = false;

    env = {
      ALLOW_REGISTRATION = "true";
      CREDS_KEY = "436d19835fc1c4437f7635dd58f1e52afe054d3d2ddcaca2b3305eade21d86986daad327f269837093747433084fcfbe230741b466901271d01d5e053e4051d5";
      CREDS_IV = "84692b48aa5737c7771f825cdeff0996470d3b6fb6c2477bf6e9064ff154185a";
      JWT_SECRET = "0dc56ce94ecf506f4e4c55fc847904f17c07a2ae68ad78f3488f3ea00b102ac4f623d1f2102c68d97daf35b1c15db4fdab240e7f4c6d85308c0d982b05a242eb";
      JWT_REFRESH_SECRET = "fd0bd1ecc973f06caa4965b387d0dccacd94665457fb61e739a9005ce38865ab03b2ddc61c8d073ccdf6b972cbd146c588d17550ade9b67105bb575ce1b55f92";
      SERPER_API_KEY = "35374e89cd4bf2d046a33b245ab42a98b8b3fab4";
    };

    settings = {
      version = "1.3.13";

      interface = {
        modelSelect = true;
        presets = true;
        webSearch = true;
      };

      webSearch = {
        searchProvider = "serper";
        serperApiKey = "\${SERPER_API_KEY}";
      };

      endpoints = {
        custom = [
          {
            name = "llama-swap";
            apiKey = "sk-anything";
            baseURL = "http://127.0.0.1:9292/v1";
            models = {
              default = [
                "qwen-35b"
                "qwen-14b"
                "qwen-9b"
                "gemma-4b"
              ];
              fetch = true;
            };
            titleConvo = true;
            titleModel = "qwen-9b";
          }
        ];
      };

      modelSpecs = {
        enforce = false;
        prioritize = true;
        list = [
          {
            name = "qwen-35b-concise";
            label = "Qwen 35B (Concise)";
            default = true;
            description = "Qwen3.6-35B-A3B tuned for short, direct day-to-day chat.";
            preset = {
              endpoint = "llama-swap";
              model = "qwen-35b";
              temperature = 1.0;
              top_p = 0.95;
              presence_penalty = 1.5;
              promptPrefix = ''
                Be concise. Answer directly without restating the question,
                adding unnecessary preamble, or hedging with caveats unless
                they're genuinely important. Prefer short paragraphs over
                bullet lists unless the user asks for a list. Get to the
                point in the first sentence.
              '';
            };
          }
          {
            name = "qwen-35b-full";
            label = "Qwen 35B (Full detail)";
            description = "Same model, no brevity constraint.";
            preset = {
              endpoint = "llama-swap";
              model = "qwen-35b";
              temperature = 1.0;
              top_p = 0.95;
              presence_penalty = 1.5;
            };
          }
        ];
      };
    };
  };

  environment.etc."llama-swap/config.yaml" = {
    text = llamaSwapConfig;
    mode = "0644";
    user = "xannyx";
  };

  environment.systemPackages = [
    llamaSwapPkg
    optimizedLlamaCpp
    pkgs.amdgpu_top
    pkgs.uv
  ];

  systemd.services.llama-swap = {
    description = "llama-swap - OpenAI compatible proxy with automatic model swapping";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "xannyx";
      Group = "users";
      ExecStart = "${llamaSwapPkg}/bin/llama-swap --config /etc/llama-swap/config.yaml --listen 127.0.0.1:9292 --watch-config";
      Restart = "always";
      RestartSec = 10;
    };
  };
}
