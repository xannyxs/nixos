{ pkgs, lib, ... }:

let
  optimizedLlamaCpp =
    (pkgs.llama-cpp.override {
      blasSupport = true;
      vulkanSupport = true;
      rocmSupport = false;
      cudaSupport = false;
      metalSupport = false;
    }).overrideAttrs
      (oldAttrs: rec {
        version = "9857";
        npmDepsHash = "sha256-X1DZgmhS/zHTqDT5zq0kywwntthcJ9vRXeqyO3zz6UU=";
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [
          pkgs.vulkan-headers
          pkgs.vulkan-loader
          pkgs.shaderc
        ];
        src = pkgs.fetchFromGitHub {
          owner = "ggml-org";
          repo = "llama.cpp";
          tag = "b${version}";
          hash = "sha256-9DHiQT1vMfO3AnBgiSTWnGY99dk8VpT9+C5uy2BseTA=";
          leaveDotGit = true;
          postFetch = ''
            git -C "$out" rev-parse --short HEAD > $out/COMMIT
            find "$out" -name .git -print0 | xargs -0 rm -rf
          '';
        };
        cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
          "-DGGML_NATIVE=ON"
          "-DGGML_VULKAN=1"
          "-DLLAMA_BUILD_SERVER=ON"
          "-DLLAMA_BUILD_TESTS=OFF"
          "-DLLAMA_BUILD_EXAMPLES=ON"
        ];
        preConfigure = ''
          export NIX_ENFORCE_NO_NATIVE=0
          ${oldAttrs.preConfigure or ""}
        '';
      });

  models = {
    qwen-14b = pkgs.fetchurl {
      url = "https://huggingface.co/unsloth/Qwen3-14B-GGUF/resolve/main/Qwen3-14B-UD-Q4_K_XL.gguf";
      hash = "sha256-fzca3qr1Hcl9qSfGHmVz514+oz127And24ytANDVtss=";
    };
    qwen-9b = pkgs.fetchurl {
      url = "https://huggingface.co/HauhauCS/Qwen3.5-9B-Uncensored-HauhauCS-Aggressive/resolve/main/Qwen3.5-9B-Uncensored-HauhauCS-Aggressive-Q4_K_M.gguf";
      hash = "sha256-LKY22egdPSPKm2DCNP4YXTDsCC7rppzncP2wx2VZpPU=";
    };
    gemma-4b = pkgs.fetchurl {
      url = "https://huggingface.co/HauhauCS/Gemma-4-E4B-Uncensored-HauhauCS-Aggressive/resolve/main/Gemma-4-E4B-Uncensored-HauhauCS-Aggressive-Q6_K_P.gguf";
      hash = "sha256-8osK4mIVivENhHw/Ab/blDFh3TEyDzrtIHde4q1sZ6Y=";
    };
  };

  commonFlags = "-ngl 99 --flash-attn on --cache-type-k q8_0 --cache-type-v q8_0 --threads 10 --batch-size 512";

  llamaSwapConfig = ''
    models:
      qwen-14b:
        cmd: |
          ${optimizedLlamaCpp}/bin/llama-server -m ${models.qwen-14b} --port ''${PORT} -c 32768 ${commonFlags}
      qwen-9b:
        cmd: |
          ${optimizedLlamaCpp}/bin/llama-server -m ${models.qwen-9b} --port ''${PORT} -c 32768 ${commonFlags}
      gemma-4b:
        cmd: |
          ${optimizedLlamaCpp}/bin/llama-server -m ${models.gemma-4b} --port ''${PORT} -c 32768 ${commonFlags}
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
  environment.etc."llama-swap/config.yaml" = {
    text = llamaSwapConfig;
    mode = "0644";
    user = "xannyx";
  };

  environment.systemPackages = [
    llamaSwapPkg
    optimizedLlamaCpp
  ];

  systemd.services.llama-swap = {
    description = "llama-swap - OpenAI compatible proxy with automatic model swapping";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    environment = {
      GGML_VULKAN_DEVICE = "1";
    };
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
