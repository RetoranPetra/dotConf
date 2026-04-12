{ nixvim, ... }:
{
  # Relies on git
  programs.git.enable = true;
  #programs.git.extraConfig.core.editor = "nvim";
  # Relies on lazygit
  programs.lazygit.enable = true;
  home.sessionVariables = {
    "EDITOR" = "nvim";
  };

  programs.nixvim = {
    imports = [ ./../../modules/nvim/config ];
    enable = true;
  };
}
