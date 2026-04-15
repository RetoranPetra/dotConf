{ ... }:
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
    ./../../../modules/home.retoran/gallery-dl
  ];
}
