{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.hostName = "wsl";
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
    kmod
    # GCC SHOULDN'T be here, putting here for now until I can sort out nvim.
    gcc
  ];

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

  nix.settings.trusted-users = [ "retoran" ];

  programs.zsh.enable = true;

  wsl.ssh-agent.enable = true;

  # Enable nix-ld for easy use of uv
  programs.nix-ld.enable = true;

  # Need to re-register as well to allow binfmt
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.binfmt.preferStaticEmulators = true;
  wsl.interop.register = true;
  services.gvfs.enable = true;

  services.gitlab-runner = {
    enable = true;
    services = {
      dockerRunner = {
        dockerImage = "alpine";
        executor = "docker";
        authenticationTokenConfigFile = "/etc/secrets/gitlab-runner-env";
        dockerPrivileged = true;
      };
    };
  };
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };


  system.stateVersion = "25.05";
}
