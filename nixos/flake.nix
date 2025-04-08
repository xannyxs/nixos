{
  description = "Xannyx's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v0.4.1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations.saturn = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-hardware.nixosModules.framework-16-7040-amd
          ./gpu.nix
          ./swap.nix
          ./cpu.nix
          ./common.nix
          ./hardware-configuration.nix
          ./audio.nix
          # ./usb.nix
          ./bootloader.nix
          ./nix-settings.nix
          ./gc.nix
          ./linux-kernel.nix
          ./screen.nix
          # ./theme.nix
          ./internationalisation.nix
          ./fonts.nix
          ./services.nix
          ./xfce.nix
          # ./gnome.nix
          # ./hyprland.nix
          ./env.nix
          ./bluetooth.nix
          ./networking.nix
          ./firewall.nix
          ./users.nix
          ./virtualisation.nix
          ./term-utils.nix
          ./time.nix
          ./firejail.nix
          ./ai.nix
        ];
      };
    };
}
