{ pkgs, lib,  ... }:

{
  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      #systemd-boot.enable = lib.mkForce false;
      systemd-boot.enable = true;
      # grub = {
      #   enable = true;
      #   device = "nodev";
      #   efiSupport = true;
      # };
    };
    #lanzaboote = {
    # enable = true;
    #pkiBundle = "/etc/secureboot";
    #};
  };
}
