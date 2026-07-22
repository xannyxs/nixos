{ pkgs, ... }:

{
  hardware = {
    graphics = with pkgs; {
      enable = true;
      enable32Bit = true;
      extraPackages = [
        rocmPackages.clr
        mesa
      ];
    };
  };

  services.power-profiles-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    vulkan-tools
    clinfo
    powertop
    nvtopPackages.amd
    radeontop
  ];
}
