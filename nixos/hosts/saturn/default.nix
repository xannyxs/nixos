# Framework 16 (AMD 7040)
{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
    inputs.lanzaboote.nixosModules.lanzaboote

    ./hardware-configuration.nix
    ./hardware.nix
    ./boot.nix

    ../../modules/core
    ../../modules/hardware
    ../../modules/networking
    ../../modules/desktop
    ../../modules/services
    ../../modules/programs

    # Not in use, kept to switch back to:
    # ../../modules/hardware/usbguard.nix
    # ../../modules/desktop/gnome.nix
    # ../../modules/desktop/hyprland.nix
    # ../../modules/desktop/theme.nix
  ];

  nixpkgs.overlays = [ inputs.self.overlays.default ];

  networking.hostName = "saturn";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
