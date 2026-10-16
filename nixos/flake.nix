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
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
    in
    {
      overlays.default = import ./pkgs;

      packages.${system} = {
        inherit (pkgs)
          llama-cpp-gfx1102
          llama-swap-bin
          routed-gothic
          tts-cpp
          ;
      };

      formatter.${system} = pkgs.nixfmt-tree;

      nixosConfigurations.saturn = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/saturn ];
      };
    };
}
