{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
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
    inputs@{
      flake-parts,
      nixpkgs,
      nixos-wsl,
      home-manager,
      nixvim,
      gallery-dl,
      lanzaboote,
      preload-ng,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {

        imports = [ ];

        flake = {
          # WSL config
          nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
            modules = [
              # WSL module NEEDED for WSL
              nixos-wsl.nixosModules.wsl
              ./hosts/wsl/configuration.nix

              (
                { config, ... }:
                {
                  nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system ({ pkgs, ... }: pkgs);
                }
              )
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
          nixosConfigurations.desktop-retoran = nixpkgs.lib.nixosSystem {
            specialArgs.gallery-dl = gallery-dl;
            modules = [
              (
                { config, ... }:
                {
                  # We made pkgs into a function that takes in configuration and combines it with the configuration to create pkgs.
                  # This lets us override parts of the config in an elegant fashion.
                  # May end up with us rebuilding pkgs for every place we reference "pkgs",
                  # but this shouldn't matter as this flake should only build a system at a time.
                  nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system (
                    { pkgs, ... }: pkgs {
                      config.rocmSupport = true;
                      hostPlatform.gcc = {
                        arch = "znver4";
                        tune = "znver4";
                      };
                    }
                  );
                }
              )
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
          nixosConfigurations.flex5-retoran = nixpkgs.lib.nixosSystem {
            modules = [
              (
                { config, ... }:
                {
                  nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system ({ pkgs, ... }: pkgs);
                }
              )
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

        systems = [ "x86_64-linux" ];

        perSystem =
          { system, ... }:
          {
            _module.args.pkgs = (
              options:
              import inputs.nixpkgs {
                inherit system;
                overlays = [
                  (final: prev: {
                    gallery-dl = (
                      prev.gallery-dl.overrideAttrs {
                        version = "git";
                        src = gallery-dl;
                      }
                    );
                    patreon-dl = import ./pkgs/patreon-dl.nix { pkgs = prev; };
                    proton-dw-bin = import ./pkgs/proton-dw-bin.nix {
                      lib = prev.lib;
                      stdenvNoCC = prev.stdenvNoCC;
                      fetchzip = prev.fetchzip;
                    };
                    vintagestory = import ./pkgs/vintagestory.nix {
                      lib = prev.lib;
                      vintagestory = prev.vintagestory;
                      fetchurl = prev.fetchurl;
                      dotnet-runtime_10 = prev.dotnet-runtime_10;
                    };
                  })
                ];
                # There should definitely be a better way of making all of these options.
                config = options.config // {
                  allowUnfree = true;
                };
                hostPlatform = options.hostPlatform;
              }
            );
          };
      }
    );
}
