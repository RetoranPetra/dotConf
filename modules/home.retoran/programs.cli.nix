{ pkgs, ... }:
{
  xdg.configFile."btop".source = ./../../root/home/retoran/.config/btop;
  xdg.configFile."gallery-dl".source = ./../../root/home/retoran/.config/gallery-dl;
  xdg.configFile."yt-dlp.conf".source = ./../../root/home/retoran/.config/yt-dlp.conf;

  home.packages = with pkgs; [
    # Nix tools
    nixfmt-classic

    # System utils
    pulsemixer
    btop-rocm
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

    # Archivers
    gallery-dl
    yt-dlp

    # Files
    rclone
    rsync
    lrzip
  ];
}
