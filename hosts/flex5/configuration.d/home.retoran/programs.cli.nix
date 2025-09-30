{ pkgs, ... }:
{
  xdg.configFile."btop".source =
    /etc/nixos/home.retoran/home/retoran/.config/btop;
  xdg.configFile."gallery-dl".source =
    /etc/nixos/home.retoran/home/retoran/.config/gallery-dl;
  xdg.configFile."yt-dlp.conf".source =
    /etc/nixos/home.retoran/home/retoran/.config/yt-dlp.conf;

  home.packages = with pkgs; [
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
