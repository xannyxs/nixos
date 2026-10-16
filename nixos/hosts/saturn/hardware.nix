{ pkgs, ... }:

{
  # CPU
  hardware.cpu.amd.updateMicrocode = true;
  boot.kernelParams = [ "amd_pstate=active" ];

  # GPU
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

  services.xserver.videoDrivers = [ "amdgpu" ];

  services.power-profiles-daemon.enable = true;

  # services.udev.extraRules = ''
  #   # Disable wake from keyboard (assuming AT Keyboard interface)
  #   ACTION=="add", SUBSYSTEM=="serio", DRIVERS=="atkbd", ATTR{power/wakeup}="disabled"
  #
  #   # Disable wake from the specific Framework 16 touchpad
  #   ACTION=="add", SUBSYSTEM=="i2c", DRIVERS=="i2c_hid_acpi", ATTRS{name}=="PIXA3854:00", ATTR{power/wakeup}="disabled"
  #
  #   # Optional: Disable wake from Lid open (PNP0C0D). Comment out if you want wake-on-lid-open.
  #   # ACTION=="add", SUBSYSTEM=="acpi", DRIVERS=="button", ATTRS{hid}=="PNP0C0D", ATTR{power/wakeup}="disabled"
  # '';

  environment.systemPackages = with pkgs; [
    mesa
    vulkan-tools
    clinfo
    powertop
    nvtopPackages.amd
    radeontop
  ];
}
