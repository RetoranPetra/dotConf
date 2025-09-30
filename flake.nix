{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # NOTE: Use our existing nixpkgs declaration for nixpkgs in home-manager
      #       so we don't have two versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    self.submodules = true;
  };
  outputs = { nixpkgs, home-manager, nixvim, ... }: {
      nixosConfigurations.flex5-retoran = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
        modules = [
          ./hosts/flex5/configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useUserPackages = true;
            home-manager.users.retoran = {
              imports =
              [
                nixvim.homeModules.nixvim
                ./hosts/flex5/configuration.d/home.retoran
              ];
            };
          }
        ];
      };
  };
}
