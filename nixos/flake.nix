{
  description = "Xannyx's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-ld,
      lanzaboote,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations.saturn = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system;
        };
        modules = [
          nix-ld.nixosModules.nix-ld
          { programs.nix-ld.dev.enable = true; }
          ./gpu.nix
          ./cpu.nix
          ./configuration.nix
          ./hardware-configuration.nix
          ./audio.nix
          ./usb.nix
          ./bootloader.nix
          ./nix-settings.nix
          ./gc.nix
          ./linux-kernel.nix
          ./screen.nix
          ./theme.nix
          ./internationalisation.nix
          ./fonts.nix
          ./services.nix
          ./gnome.nix
          ./env.nix
          ./bluetooth.nix
          ./networking.nix
          ./firewall.nix
          ./users.nix
          ./virtualisation.nix
          ./term-utils.nix
          ./time.nix
        ];
      };
    };
}
