{ lib, pkgs, ... }:
let
  voice = "af_heart";
  chunkChars = 400;

  kokoro = pkgs.fetchurl {
    url = "https://huggingface.co/mmwillet2/Kokoro_GGUF/resolve/main/Kokoro_espeak.gguf";
    hash = "sha256-c+PWV8UtbYNZoyPakGwaHdWujxVaN8slvLfpNT440jA=";
  };

  tts-cli = lib.getExe pkgs.tts-cpp;

  readChunk = pkgs.writeShellApplication {
    name = "tts-read-chunk";
    runtimeInputs = [ pkgs.gnugrep ];
    text = ''
      # Skip a part with no letters and no numbers.
      grep -q '[[:alnum:]]' "$1" || exit 0

      ${tts-cli} \
        --model-path ${kokoro} \
        --voice ${voice} \
        --n-threads "''${TTS_THREADS:-1}" \
        --prompt "$(cat "$1")" \
        --save-path "''${1%.txt}.wav"
    '';
  };

  readArticle = pkgs.writeShellApplication {
    name = "read-article";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.findutils
      pkgs.gawk
      pkgs.sox
      pkgs.util-linux
      readChunk
    ];
    text = ''
      if [ "$#" -lt 1 ]; then
        echo "usage: read-article TEXT_FILE [OUT_WAV]" >&2
        exit 1
      fi

      out="''${2:-/tmp/article.wav}"
      work="$(mktemp -d)"
      trap 'rm -rf "$work"' EXIT
      shopt -s nullglob

      # Cut the text into parts at sentence ends.
      gawk -v dir="$work" -v limit=${toString chunkChars} '
        function emit(i, b,   f) {
          f = sprintf("%s/part-%04d.txt", dir, i)
          printf "%s", b > f
          close(f)
        }
        BEGIN { RS = "[.!?]"; n = 0; buf = "" }
        {
          buf = buf $0 RT
          if (length(buf) > limit) { emit(n++, buf); buf = "" }
        }
        END { if (buf ~ /[^[:space:]]/) emit(n, buf) }
      ' "$1"

      parts=("$work"/part-*.txt)
      if [ "''${#parts[@]}" -eq 0 ]; then
        echo "read-article: no text found in $1" >&2
        exit 1
      fi

      # Divide the physical cores between the parts. SMT gives no gain.
      cores="''${TTS_CORES:-$(lscpu -p=CORE,SOCKET | grep -vc '^#')}"
      njobs="''${TTS_JOBS:-$(( ''${#parts[@]} < cores ? ''${#parts[@]} : cores ))}"
      [ "$njobs" -ge 1 ] || njobs=1
      export TTS_THREADS="''${TTS_THREADS:-$(( cores / njobs ))}"
      [ "$TTS_THREADS" -ge 1 ] || export TTS_THREADS=1

      echo "parts: ''${#parts[@]}  jobs: $njobs  threads: $TTS_THREADS" >&2

      printf '%s\0' "''${parts[@]}" \
        | xargs -0 -n1 -P "$njobs" tts-read-chunk

      wavs=("$work"/part-*.wav)
      sox "''${wavs[@]}" "$out"
      echo "wrote $out" >&2
    '';
  };

  ttsBench = pkgs.writeShellApplication {
    name = "tts-bench";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.gawk
      pkgs.util-linux
    ];
    text = ''
      file="''${1:-/tmp/t.txt}"
      threads="''${TTS_THREADS:-$(lscpu -p=CORE,SOCKET | grep -vc '^#')}"

      ${tts-cli} \
        --model-path "''${TTS_MODEL:-${kokoro}}" \
        --voice ${voice} \
        --n-threads "$threads" \
        --prompt "$(head -c ${toString chunkChars} "$file")" \
        --save-path /tmp/bench.wav \
      | gawk -v t="$threads" '
          /Length in Seconds/ { audio = $NF }
          /total time/        { ms = $(NF-1) }
          END {
            printf "threads %d | %.1f s for %.2f s audio | RTF %.2f\n",
              t, ms / 1000, audio, (ms / 1000) / audio
          }'
    '';
  };
in
{
  environment.systemPackages = [
    pkgs.tts-cpp
    readArticle
    ttsBench
  ];
}
