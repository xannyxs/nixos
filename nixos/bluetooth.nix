{ ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };

    input = {
      General = {
        UserspaceHID = true; # For Magic mouse and keyboard
      };
    };
  };
  services.blueman.enable = true;
}
