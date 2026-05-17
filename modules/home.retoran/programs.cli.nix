{ pkgs, ... }:
{
  xdg.configFile."btop".source = ./../../root/home/retoran/.config/btop;
  xdg.configFile."yt-dlp.conf".source = ./../../root/home/retoran/.config/yt-dlp.conf;

  home.packages = with pkgs; [
    # Nix tools
    nixfmt
    nh

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
    yt-dlp
    patreon-dl

    # Files
    rclone
    rsync
    lrzip
    p7zip
  ];
}
