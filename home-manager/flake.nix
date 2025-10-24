{
  description = "Home Manager configuration of xannyx";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # catppuccin.url = "github:catppuccin/nix";
    # spicetify-nix = {
    #   url = "github:Gerg-L/spicetify-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      neovim-nightly,
      # catppuccin,
      # spicetify-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      userConfig = {
        name = "xannyx";
      };
      overlays = [
        inputs.neovim-nightly.overlays.default
      ];
    in
    {
      homeConfigurations.${userConfig.name} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
            userConfig
            neovim-nightly
            # catppuccin
            # spicetify-nix
            ;
        };

        modules = [
          ./home.nix
          {
            nixpkgs.overlays = overlays;
          }
        ];
      };
    };
}
