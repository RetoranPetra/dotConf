{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.retoran.programs-cli;
in
{
  imports = [
    ./archivers
    ./git.nix
    ./neovim.nix
  ];
  options.retoran.programs-cli = {
    enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
  };
  config = lib.mkIf cfg.enable {
    xdg.configFile."btop".source = ./../../root/home/retoran/.config/btop;
    home.packages = with pkgs; [
      # Nix tools
      nixfmt
      nh

      # System utils
      pulsemixer
      btop
      strace

      # Networking
      fping
      traceroute

      # Essential
      ffmpeg
      wget
      bat
      fzf
      fd
      jq
      jo
      tmux
      ripgrep-all

      # Files
      rclone
      rsync
      lrzip
      p7zip
    ];
  };
}
