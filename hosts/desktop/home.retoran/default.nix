{ config, pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./../../../modules/home.retoran/alacritty
    ./../../../modules/home.retoran/localbin
    ./../../../modules/home.retoran/programs.desktop
    ./../../../modules/home.retoran/userscripts
    ./../../../modules/home.retoran/fcitx5.nix
    ./../../../modules/home.retoran/git.nix
    ./../../../modules/home.retoran/neovim.nix
    ./../../../modules/home.retoran/programs.cli.nix
    ./../../../modules/home.retoran/state-version.nix
    ./../../../modules/home.retoran/theme.nix
    ./../../../modules/home.retoran/zsh.nix
    ./../../../modules/home.retoran/handlr.nix
    ./../../../modules/home.retoran/prismlauncher.nix
    ./../../../modules/home.retoran/gallery-dl
    ./../../../modules/home.retoran/programs.desktop/obs-studio.nix
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
