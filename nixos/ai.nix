{ ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    loadModels = [
      "deepseek-r1"
      "llama3.2"
      "llama2-uncensored"
    ];
    rocmOverrideGfx = "11.0.2";
  };
}
