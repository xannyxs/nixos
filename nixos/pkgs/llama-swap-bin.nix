{
  runCommand,
  gnutar,
  fetchurl,
}:

runCommand "llama-swap" { buildInputs = [ gnutar ]; } ''
  mkdir -p $out/bin
  mkdir -p temp_extract
  tar -xzf ${
    fetchurl {
      url = "https://github.com/mostlygeek/llama-swap/releases/download/v251/llama-swap_251_linux_amd64.tar.gz";
      hash = "sha256-hb1/Ix9Xd/9ri3h6eU+CVni40ELNRIQERRaljs3HYis=";
    }
  } -C temp_extract
  find temp_extract -type f -name "llama-swap" -exec cp {} $out/bin/ \;
  chmod +x $out/bin/llama-swap
''
