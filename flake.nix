{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      # NOTE: Use our existing nixpkgs declaration for nixpkgs in home-manager
      #       so we don't have two versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preload-ng = {
      url = "github:miguel-b-p/preload-ng";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gallery-dl = {
      url = "github:mikf/gallery-dl/master";
      flake = false;
    };
    self.submodules = true;
  };
  # @inputs allows access to inputs from inputs.INPUT as well as the direct mapping.
  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      preload-ng,
      nixos-wsl,
      lanzaboote,
      ...
    }@inputs:
    {
      nixpkgs.overlays = [(final: prev: {
        gallery-dl = prev.gallery-dl.overrideAttrs {
          version = "git";
          src = inputs.gallery-dl;
        };
      })];
      # WSL config
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        modules = [
          # WSL module NEEDED for WSL
          nixos-wsl.nixosModules.wsl
          ./hosts/wsl/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.retoran = {
              imports = [
                nixvim.homeModules.nixvim
                ./modules/home.retoran/neovim.nix
                ./modules/home.retoran/zsh.nix
                ./modules/home.retoran/programs.cli.nix
                ./modules/home.retoran/state-version.nix
                ./modules/home.retoran/git.nix
              ];
            };
          }
        ];
      };
      nixosConfigurations.desktop-retoran = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        modules = [
          lanzaboote.nixosModules.lanzaboote
          ./hosts/desktop/nixos
          # Preload
          preload-ng.nixosModules.default
          { services.preload-ng.enable = true; }

          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.retoran = {
              imports = [
                nixvim.homeModules.nixvim
                ./hosts/desktop/home.retoran
              ];
            };
          }
        ];
      };
      nixosConfigurations.flex5-retoran = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        modules = [
          ./hosts/flex5/nixos
          preload-ng.nixosModules.default
          {
            services.preload-ng.enable = true;
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.retoran = {
              imports = [
                nixvim.homeModules.nixvim
                ./hosts/flex5/home.retoran
              ];
            };
          }
        ];
      };
    };
}
