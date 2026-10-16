{ pkgs, ... }:

{
  services.dbus.enable = true;
  services.upower.enable = true;
  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [
    libmtp
  ];
}
