{ pkgs, ... }:

{
  services.usbguard = {
    enable = true;
    dbus.enable = true;
    implicitPolicyTarget = "block";
    presentControllerPolicy = "keep";
    IPCAllowedUsers = [
      "root"
      "xannyx"
    ];

  };

  environment.systemPackages = with pkgs; [
    usbguard-notifier
    usbutils
    exfat
    exfatprogs
    gparted
  ];
}
