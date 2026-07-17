{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libcanberra-gtk3
    xkill
    xclip
  ];

  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      accelProfile = "adaptive";
      naturalScrolling = true;
      clickMethod = "clickfinger";
    };
  };
}
