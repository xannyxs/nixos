{ ... }:

{
  # services.open-webui.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "rocm";
    loadModels = [
      "deepseek-r1:latest"
      "deepseek-r1:1.5b"
      "llama3.2"
      "gemma3n"
      "gemma3"
    ];
    rocmOverrideGfx = "11.0.2";
  };
}
