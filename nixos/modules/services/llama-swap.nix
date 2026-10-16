{ pkgs, lib, ... }:

let
  models = {
    qwen35-9b = pkgs.fetchurl {
      url = "https://huggingface.co/unsloth/Qwen3.5-9B-MTP-GGUF/resolve/main/Qwen3.5-9B-IQ4_NL.gguf";
      hash = "sha256-PsC4v7zaIT+6REDtW+HZ95DnBltOVmA6zaxjQH4adds=";
    };
    unsloth-qwen36-35b-a3b-mtp-gguf = pkgs.fetchurl {
      url = "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-MTP-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-IQ4_NL.gguf";
      hash = "sha256-0K14BHvQpYO/y0hOne/GMRLF8fhW4xDc+I3Ejy6+rls=";
    };
    mudler-qwen3-6-35b-a3b-apex-gguf = pkgs.fetchurl {
      url = "https://huggingface.co/mudler/Qwen3.6-35B-A3B-APEX-MTP-GGUF/resolve/main/Qwen3.6-35B-A3B-APEX-MTP-I-Compact.gguf";
      hash = "sha256-d1irA6YA9IbotQsqRUh0oDtSwRpvgT21YXSem+s6sG4=";
    };
    gemma-4-E4B-it-mtp-draft = pkgs.fetchurl {
      url = "https://huggingface.co/unsloth/gemma-4-E4B-it-qat-GGUF/resolve/main/MTP/mtp-gemma-4-E4B-it-Q8_0.gguf";
      hash = "sha256-xWb2iFljyDoNho+WVih+1dTxKiuPDIaiBST4mpYWntI=";
    };
    gemma-4-E4B-it-qat = pkgs.fetchurl {
      url = "https://huggingface.co/unsloth/gemma-4-E4B-it-qat-GGUF/resolve/main/gemma-4-E4B-it-qat-UD-Q4_K_XL.gguf";
      hash = "sha256-3w/U7gcHLGB8KaChy0+YkYQmzKEvRaJ3a91u5tCaTeM=";
    };

  };

  modelProfiles = {
    gemma-e4b = {
      model = models.gemma-4-E4B-it-qat;
      contextSize = 32768;
      kvCacheType = "f16";
      flashAttn = "off";
      extraFlags = [
        "-ngl"
        "99"
        "--model-draft"
        "${models.gemma-4-E4B-it-mtp-draft}"
        "--fit"
        "off"
        "--spec-type"
        "draft-mtp"
        "--spec-draft-n-max"
        "2"
        "--temp"
        "1.0"
        "--top-p"
        "0.95"
        "--top-k"
        "64"
      ];
    };
    qwen35-9b = {
      model = models.qwen35-9b;
      contextSize = 32768;
      kvCacheType = "q8_0";
      flashAttn = "on";
      extraFlags = [
        "-ngl"
        "99"
        "--spec-type"
        "draft-mtp"
        "--spec-draft-n-max"
        "2"
        "--temp"
        "1.0"
        "--top-p"
        "0.95"
        "--top-k"
        "20"
        "--min-p"
        "0.00"
      ];
    };

    qwen36-35b-a3b-apex = {
      model = models.mudler-qwen3-6-35b-a3b-apex-gguf;
      contextSize = 32768;
      kvCacheType = "q8_0";
      flashAttn = "on";
      extraFlags = [
        "-ngl"
        "99"
        "--n-cpu-moe"
        "35"
        "--load-mode"
        "none"
        "--spec-type"
        "draft-mtp"
        "--spec-draft-n-max"
        "2"
      ];
    };

    qwen36-35b-a3b = {
      model = models.unsloth-qwen36-35b-a3b-mtp-gguf;
      contextSize = 65536;
      kvCacheType = "q8_0";
      flashAttn = "on";
      extraFlags = [
        "-ngl"
        "99"
        "--n-cpu-moe"
        "32"
        "--load-mode"
        "none"
        "--spec-type"
        "draft-mtp"
        "--spec-draft-n-max"
        "2"
      ];
    };
  };

  llamaSwapConfig = lib.generators.toYAML { } {
    models = lib.mapAttrs (name: p: {
      cmd = lib.concatStringsSep " " (
        [
          "${pkgs.llama-cpp-gfx1102}/bin/llama-server"
          "-m"
          "${p.model}"
          "--port"
          "\${PORT}"
          "-c"
          (toString p.contextSize)
          "--flash-attn"
          p.flashAttn

          "--parallel"
          "1"

          "--cache-type-k"
          p.kvCacheType
          "--cache-type-v"
          p.kvCacheType
          "--threads"
          "8"
        ]
        ++ p.extraFlags
      );
    }) modelProfiles;
  };
in
{
  environment.etc."llama-swap/config.yaml" = {
    text = llamaSwapConfig;
    mode = "0644";
    user = "xannyx";
  };

  # services.open-webui = {
  #   enable = true;
  #   environment = {
  #     WEBUI_AUTH = "False";
  #     ENABLE_OLLAMA_API = "False";
  #     OPENAI_API_BASE_URLS = "http://127.0.0.1:9292/v1";
  #     OPENAI_API_KEYS = "sk-local";
  #   };
  # };

  environment.systemPackages = [
    pkgs.llama-swap-bin
    pkgs.llama-cpp-gfx1102

    pkgs.uv
    pkgs.amdgpu_top
    pkgs.rocmPackages.rocminfo
  ];

  systemd.services.llama-swap = {
    description = "llama-swap - OpenAI compatible proxy with automatic model swapping";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      User = "xannyx";
      Group = "users";
      ExecStart = "${pkgs.llama-swap-bin}/bin/llama-swap --config /etc/llama-swap/config.yaml --listen 127.0.0.1:9292 --watch-config";
      Restart = "always";
      RestartSec = 10;
    };
  };
}
