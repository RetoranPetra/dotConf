{ nixvim, ... }:
{
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
}
