let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-25.05";
  });
in { config, lib, pkgs, ... }: {
  imports = [ <home-manager/nixos> ];
  home-manager.users.retoran = { pkgs, ... }: {
    imports = [ nixvim.homeModules.nixvim ];
    # Relies on git
    programs.git.enable = true;
    #programs.git.extraConfig.core.editor = "nvim";
    # Relies on lazygit
    programs.lazygit.enable = true;

    programs.nixvim = {
      imports = [ /etc/nixos/home.retoran/home/retoran/.config/nvim/config ];
      enable = true;
    };
  };
}
