{ config, pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./../../../modules/home.retoran
  ];

  # Use real paths for user directories
  xdg.userDirs = {
    enable = true;
    # Recommended way from home version 26.05 onwards
    setSessionVariables = false;
  };
  home.file.Pictures.source = config.lib.file.mkOutOfStoreSymlink "/mnt/raidn0/retoran/Pictures";
  home.file.Videos.source = config.lib.file.mkOutOfStoreSymlink "/mnt/raidn0/retoran/Videos";
  home.file.Music.source = config.lib.file.mkOutOfStoreSymlink "/mnt/raidn0/retoran/Music";
  home.file.Documents.source = config.lib.file.mkOutOfStoreSymlink "/mnt/raidn0/retoran/Documents";
  home.file.Source.source = config.lib.file.mkOutOfStoreSymlink "/mnt/raidn0/retoran/Source";
  home.packages = [
    pkgs.vintagestory
  ];
}
