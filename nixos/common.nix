{ ... }:

{
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

  nixpkgs.config.allowUnfree = true;
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
