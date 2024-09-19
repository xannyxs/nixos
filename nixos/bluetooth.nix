{ ... }:

{
  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    input = {
      General = {
        UserspaceHID = true; # For Magic mouse and keyboard
      };
    };
  };
  services.blueman.enable = true;
}
