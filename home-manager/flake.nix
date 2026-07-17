{
  description = "Home Manager configuration of xannyx";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      userConfig = {
        name = "xannyx";
      };
    in
    {
      homeConfigurations.${userConfig.name} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit
            userConfig
            ;
        };

        modules = [
          ./home.nix
          {
          }
        ];
      };
    };
}
