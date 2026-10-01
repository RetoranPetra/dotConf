{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.retoran.git;
in
{
  options.retoran.git = {
    gitlab.enable = lib.mkDefault true;
    github.enable = lib.mkDefault true;
    enable = lib.mkDefault true;
  };
  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.git = {
          enable = true;
          settings = {
            user = {
              email = "flyro@live.co.uk";
              name = "RetoranPetra";
            };
            init.defaultBranch = "main";
          };
          lfs.enable = true;
        };
        programs.lazygit.enable = true;
      }
      (lib.mkIf cfg.gitlab.enable {
        programs.git.settings = {
          credential."https://github.com".helper = "!/usr/bin/env gh auth git-credential";
          credential."https://gist.github.com".helper = "!/usr/bin/env gh auth git-credential";
        };
        home.packages = [ pkgs.gh ];
      })
      (lib.mkIf cfg.github.enable {
        programs.git.settings.credential."https://gitlab.com".helper =
          "!${pkgs.glab}/bin/.glab-wrapped auth git-credential";
        home.packages = [ pkgs.glab ];
      })
    ]
  );
}
