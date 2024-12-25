{
  description = "Nixos config flake";

  inputs = {
    # Use the nixpkgs unstable branch
    nixpkgs.url = "github:nixos/nixpkgs?ref=master";  # This is the unstable branch of nixpkgs
    # Use the home-manager unstable release
    home-manager.url = "github:nix-community/home-manager?ref=master";  # This is the unstable branch of home-manager
    home-manager.inputs.nixpkgs.follows = "nixpkgs";  # Ensure home-manager follows the nixpkgs version
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./hosts/default/configuration.nix
          ];
        };
      };
    };
}
