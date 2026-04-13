{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.hostName = "wsl";
  security.pki.certificates = [
    (builtins.readFile /mnt/c/WSLCerts/nixos-org-chain.pem)
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    wget
    bat
    rclone
    lrzip
    traceroute
    git
    git-lfs
    gh
    lazygit
    fzf
    fd
    jq
    jo
    strace
    tmux
    ripgrep-all
    nixfmt
    # GCC SHOULDN'T be here, putting here for now until I can sort out nvim.
    gcc
  ];

  virtualisation.docker.enable = true;

  wsl.enable = true;
  wsl.defaultUser = "retoran";

  # Add retoran user
  users.users.retoran = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  system.stateVersion = "25.05";
}
