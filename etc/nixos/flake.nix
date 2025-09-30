{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";

    # unsure if I need to define more things here, leaving for now.
  };
  outputs = { self, nixpkgs, home-manager }@attrs: {
      nixosConfigurations.flex5-retoran = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };
        modules = [
          ./configuration.nix
          # This fixes nixpkgs (for e.g. "nix shell") to match the system nixpkgs
          ({ config, pkgs, options, ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
        ];
      };
  };
}
