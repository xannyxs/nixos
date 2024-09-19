{
  description = "Xannyx's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, lanzaboote, ... } @ inputs:
    {
      nixosConfigurations.xannyx = nixpkgs.lib.nixosSystem {


        specialArgs = { inherit inputs; };
        modules = [
          lanzaboote.nixosModules.lanzaboote

          ./gpu.nix
          ./cpu.nix
          ./configuration.nix
          ./hardware-configuration.nix
          # ./opengl.nix
          # ./fingerprint-scanner.nix
          # ./clamav-scanner.nix
          ./audio.nix
          ./usb.nix
          # ./time.nix
          # ./swap.nix
          ./bootloader.nix
          ./nix-settings.nix
          # ./nixpkgs.nix
          ./gc.nix
          # ./auto-upgrade.nix
          ./linux-kernel.nix
          ./screen.nix
          ./display-manager.nix
          ./theme.nix
          ./internationalisation.nix
          ./fonts.nix
          # ./security-services.nix
          ./services.nix
          # ./printing.nix
          ./hyprland.nix
          ./env.nix
          ./bluetooth.nix
          ./networking.nix
          # ./mac-randomize.nix
          # ./open-ssh.nix
          ./firewall.nix
          # ./dns.nix
          # ./vpn.nix
          ./users.nix
          ./virtualisation.nix
          # ./programming-languages.nix
          # ./lsp.nix
          # ./utils.nix
          ./term-utils.nix
        ];
      };
    };
}
