{ lib, pkgs, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocmPackages.clr.icd
        rocm-opencl-runtime
        mesa
        mesa.drivers
        # amdvlk
      ];
    };

    # AMDGPU specific configuration
    amdgpu.initrd.enable = lib.mkDefault true;
  };

  # Kernel parameters for Southern Islands GPUs
  boot.kernelParams = [
    "radeon.si_support=0"
    "amdgpu.si_support=1"
  ];

  environment.systemPackages = with pkgs; [
    clinfo
  ];
}
