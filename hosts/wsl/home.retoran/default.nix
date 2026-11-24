{ ... }: {
  imports = [
    ./../../../modules/home.retoran/neovim.nix
    ./../../../modules/home.retoran/zsh.nix
    ./../../../modules/home.retoran/programs.cli.nix
    ./../../../modules/home.retoran/state-version.nix
    ./../../../modules/home.retoran/git.nix
  ];
}
