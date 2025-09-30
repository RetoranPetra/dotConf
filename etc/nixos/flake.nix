{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # NOTE: Use our existing nixpkgs declaration for nixpkgs in home-manager
      #       so we don't have two versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, ... }: {
      nixosConfigurations.flex5-retoran = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useUserPackages = true;
            home-manager.users.retoran = {
              imports = [ ./configuration.d/home.retoran ];
            };
          }
        ];
      };
  };
}
