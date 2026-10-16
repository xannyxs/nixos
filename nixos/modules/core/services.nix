{ pkgs, ... }:

{
  services.dbus.enable = true;
  services.upower.enable = true;
  services.fwupd.enable = true;
  services.usbmuxd.enable = true; # tmp

  environment.systemPackages = with pkgs; [
    libmtp
  ];
}
