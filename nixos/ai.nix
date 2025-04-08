{ ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    loadModels = [
      "deepseek-r1"
      "deepseek-r1:1.5b"
      "llama3.2"
    ];
    rocmOverrideGfx = "11.0.2";
  };
}
