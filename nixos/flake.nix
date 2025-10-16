{
  description = "Xannyx's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      lanzaboote,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations.saturn = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          lanzaboote.nixosModules.lanzaboote
          (
            { pkgs, lib, ... }:
            {

              environment.systemPackages = [
                pkgs.sbctl
              ];
              boot.loader.systemd-boot.enable = lib.mkForce false;

              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/var/lib/sbctl";
              };
            }
          )

          ./gpu.nix
          ./cpu.nix
          ./common.nix
          ./hardware-configuration.nix
          ./audio.nix
          ./bootloader.nix
          ./nix-settings.nix
          ./gc.nix
          ./linux-kernel.nix
          ./screen.nix
          ./internationalisation.nix
          ./fonts.nix
          ./services.nix
          ./xfce.nix
          ./env.nix
          ./bluetooth.nix
          ./networking.nix
          ./firewall.nix
          ./users.nix
          ./virtualisation.nix
          ./term-utils.nix
          ./time.nix
          ./security.nix
          # ./usb.nix
          # ./ai.nix
          # ./theme.nix
          # ./gnome.nix
          # ./hyprland.nix
          # ./firejail.nix
        ];
      };
    };
}
