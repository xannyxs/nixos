{ pkgs, ... }:

{
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    graphics = with pkgs; {
      enable = true;
      enable32Bit = true;
      extraPackages = [
        # amdvlk
        rocmPackages.clr
        rocmPackages.clr.icd
        mesa
      ];
      # extraPackages32 = [ driversi686Linux.amdvlk ];
    };
  };

  services.power-profiles-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    vulkan-tools
    clinfo
    # glxinfo
    powertop
    nvtopPackages.amd
    lm_sensors
    radeontop
  ];
}
