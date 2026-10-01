{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.retoran.neovim;
in
{
  options.retoran.neovim.enable = lib.mkDefault true;
  config = lib.mkIf cfg.enable {
    # Relies on git
    programs.git.enable = true;
    #programs.git.extraConfig.core.editor = "nvim";
    # Relies on lazygit
    programs.lazygit.enable = true;
    home.sessionVariables = {
      "EDITOR" = "nvim";
    };

    programs.nixvim = {
      imports = [ ./../../../modules/nvim/config ];
      nixpkgs.pkgs = pkgs;
      enable = true;
    };
  };
}
