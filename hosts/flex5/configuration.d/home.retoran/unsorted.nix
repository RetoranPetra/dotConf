{ pkgs, ... }:
{
  home.sessionPath = [
    # Should probably move things from .bin to .local/bin
    "$HOME/.bin"
    "$HOME/.local/bin"
  ];
  programs.alacritty = {
    enable = true;
    settings = { terminal.shell = "zsh"; };
  };

  home.file.".scripts".source = /etc/nixos/home.retoran/home/retoran/.scripts;
  home.file.".env".source = /etc/nixos/home.retoran/home/retoran/.env;
  home.file.".bin".source = /etc/nixos/home.retoran/home/retoran/.bin;

  home.stateVersion = "25.05"; # From myself: don't change this manually until you update the channel
}
