{ pkgs, ... }:

{
  # Enable USB Guard

  # FIXME: set yours pref USB devices (change {id} to your trusted USB device), use `lsusb` command (from usbutils package) to get list of all connected USB devices including integrated devices like camera, bluetooth, wifi, etc. with their IDs or just disable `usbguard`

  services.usbguard = {
    enable = true;
    dbus.enable = true;
    implicitPolicyTarget = "block";
    rules = ''allow id #an id'';
  };

  # Enable USB-specific packages
  environment.systemPackages = with pkgs; [
    usbutils
    exfat
    exfatprogs
    gparted
  ];
}
