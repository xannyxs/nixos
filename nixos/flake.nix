{
  description = "Xannyx's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    st-src = {
      url = "git+https://codeberg.org/xannyx/st.git?ref=master";
      flake = false;
    };
    dwm-src = {
      url = "git+https://codeberg.org/xannyx/dwm.git?ref=master";
      flake = false;
    };
    dmenu-src = {
      url = "git+https://codeberg.org/xannyx/dmenu.git?ref=master";
      flake = false;
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

      st-src,
      dwm-src,
      dmenu-src,
      ...
    }:
    {
      nixosConfigurations.saturn = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit st-src dwm-src dmenu-src; };
        modules = [
          lanzaboote.nixosModules.lanzaboote
          (
            { pkgs, lib, ... }:
            {
              environment.systemPackages = with pkgs; [
                sbctl
                tpm2-tools
              ];

              boot.loader.systemd-boot.enable = lib.mkForce false;
              boot.initrd.systemd.enable = true;
              boot.lanzaboote.configurationLimit = 8;

              boot.lanzaboote = {
                enable = true;
                pkiBundle = "/var/lib/sbctl";
                measuredBoot = {
                  enable = true;
                  pcrs = [
                    0
                    4
                    7
                  ];
                };

              };
            }
          )

          ./modules/suckless.nix
          ./xfce.nix

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
          ./env.nix
          ./bluetooth.nix
          ./networking.nix
          ./firewall.nix
          ./users.nix
          ./virtualisation.nix
          ./term-utils.nix
          ./time.nix
          ./security.nix
          ./ai.nix
          ./xlib.nix

          # ./hyprland.nix
          # ./usb.nix
          # ./firejail.nix
        ];
      };
    };
}
