{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # NOTE: Use our existing nixpkgs declaration for nixpkgs in home-manager
      #       so we don't have two versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    preload-ng = {
      url = "github:miguel-b-p/preload-ng";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    self.submodules = true;
  };
  # @inputs allows access to inputs from inputs.INPUT as well as the direct mapping.
  outputs =
    { nixpkgs, home-manager, nixvim, nur, preload-ng, nixos-wsl, ... }@inputs: {
      # WSL config
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        modules = [
          # WSL module NEEDED for WSL
          nixos-wsl.nixosModules.wsl
          ./hosts/wsl/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.retoran = {
              imports = [
                nixvim.homeModules.nixvim
                ./hosts/flex5/configuration.d/home.retoran/neovim.nix
                ./hosts/flex5/configuration.d/home.retoran/zsh.nix
                ./hosts/flex5/configuration.d/home.retoran/programs.cli.nix
                ./hosts/flex5/configuration.d/home.retoran/state-version.nix
                ./hosts/flex5/configuration.d/home.retoran/git.nix
              ];
            };
          }
        ];
      };
      nixosConfigurations.desktop-retoran = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        modules = [
          ./hosts/desktop/configuration.nix
          # Preload
          preload-ng.nixosModules.default
          { services.preload-ng.enable = true; }

          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.users.retoran = {
              imports = [
                nixvim.homeModules.nixvim
                ./hosts/desktop/configuration.d/home.retoran/alacritty
                ./hosts/desktop/configuration.d/home.retoran/hyprland
                ./hosts/desktop/configuration.d/home.retoran/programs.desktop
                ./hosts/desktop/configuration.d/home.retoran/fcitx5.nix
                ./hosts/desktop/configuration.d/home.retoran/git.nix
                ./hosts/desktop/configuration.d/home.retoran/neovim.nix
                ./hosts/desktop/configuration.d/home.retoran/programs.cli.nix
                ./hosts/desktop/configuration.d/home.retoran/theme.nix
                ./hosts/desktop/configuration.d/home.retoran/state-version.nix
                ./hosts/desktop/configuration.d/home.retoran/zsh.nix
                ./hosts/desktop/configuration.d/home.retoran/localbin
                ./hosts/desktop/configuration.d/home.retoran/userscripts
              ];
            };
          }
        ];
      };
    };
}
