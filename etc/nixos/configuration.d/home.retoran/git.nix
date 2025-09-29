{ pkgs, ... }:
{
  # Git configuration
  programs.git = {
    enable = true;
    userEmail = "flyro@live.co.uk";
    userName = "RetoranPetra";
    extraConfig = {
      init.defaultBranch = "main";
      credential."https://github.com".helper =
        "!/usr/bin/env gh auth git-credential";
      credential."https://gist.github.com".helper =
        "!/usr/bin/env gh auth git-credential";
    };

    lfs.enable = true;
  };
  # This doesn't work
  /* programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };
  */
  programs.lazygit = { enable = true; };
  home.packages = with pkgs; [
    gh
  ];
}
