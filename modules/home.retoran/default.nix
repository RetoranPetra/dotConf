{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./zsh.nix
    ./programs.cli
    ./programs.desktop
    ./desktop
    ./userscripts
  ];
  config = {
    home.stateVersion = "25.05"; # From myself: don't change this manually until you update the channel
  };
}
