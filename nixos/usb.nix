{ pkgs, ... }:

{
  # FIXME: set yours pref USB devices (change {id} to your trusted USB device), use `lsusb` command (from usbutils package) to get list of all connected USB devices including integrated devices like camera, bluetooth, wifi, etc. with their IDs or just disable `usbguard`
  services.usbguard = {
    enable = true;
    dbus.enable = true;
    implicitPolicyTarget = "block";
    rules = ''
      allow id 1d6b:0002 # Linux Foundation 2.0 root hub
      allow id 05e3:0625 # Genesys Logic, Inc. USB3.2 Hub
      allow id 0e8d:e616 # MediaTek Inc. Wireless_Device
      allow id 27c6:609c # Shenzhen Goodix Technology Co.,Ltd. Goodix USB2.0 MISC
      allow id 32ac:0012 # Framework Laptop 16 Keyboard Module - ANSI
      allow id 1d6b:0003 # Linux Foundation 3.0 root hub
      allow id 32ac:0002 # Framework HDMI Expansion Card
      allow id 05e3:0610 # Genesys Logic, Inc. Hub
      allow id 32ac:0009 # Framework SD Expansion Card
      allow id 0bda:8153 # Giganet Ethernet

      # Hard Drives
      allow id 0781:55ae # SanDisk Corp. Extreme 55AE
      allow id 04e8:61fb # Samsung Electronics Co., Ltd PSSD T7 Shield
      allow id 04e8:61f5 # Samsung Electronics Co., Ltd Portable SSD T5
      allow id 04e8:61fd # Samsung Electronics Co., Ltd PSSD T9

      # USB
      allow id 090c:1000 # Silicon Motion, Inc. - Taiwan Flash Drive
      allow id 2109:0817 # Nexus

      # General
      allow id 1d6b:0003 # Linux Foundation 3.0 root hub
      allow id 05e3:0625 # Genesys Logic, Inc. USB3.2 Hub
      allow id 2109:0817 # VIA Labs, Inc. USB3.0 Hub   
      allow id 1edb:be55 # Blackmagic design Blackmagic Design
      allow id 1edb:be83 # Blackmagic design ATEM Mini Extreme ISO
      allow id 0bda:5634 # Realtek Semiconductor Corp. Laptop Camera
      allow id 1edb:be55 # Blackmagic design ATEM Mini Pro
    '';
  };

  # Enable USB-specific packages
  environment.systemPackages = with pkgs; [
    usbguard-notifier
    usbutils
    exfat
    exfatprogs
    gparted
  ];
}
