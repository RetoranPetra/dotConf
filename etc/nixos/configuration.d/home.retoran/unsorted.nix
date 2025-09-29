{ pkgs, ... }:
{
  home.sessionPath = [
    # Should probably move things from .bin to .local/bin
    "$HOME/.bin"
    "$HOME/.local/bin"
  ];
  programs.alacritty = {
    enable = true;
    settings = { terminal.shell = "zsh"; };
  };

  # Linking existing .dotconf files
  xdg.configFile."btop".source =
    /etc/nixos/home.retoran/home/retoran/.config/btop;
  xdg.configFile."gallery-dl".source =
    /etc/nixos/home.retoran/home/retoran/.config/gallery-dl;
  xdg.configFile."yt-dlp.conf".source =
    /etc/nixos/home.retoran/home/retoran/.config/yt-dlp.conf;

  home.file.".scripts".source = /etc/nixos/home.retoran/home/retoran/.scripts;
  home.file.".env".source = /etc/nixos/home.retoran/home/retoran/.env;
  home.file.".bin".source = /etc/nixos/home.retoran/home/retoran/.bin;

  home.packages = with pkgs; [
    # System utilities
    pulsemixer
    btop-rocm

    # CLI programs
    gallery-dl
    fping
    ffmpeg
  ];

  home.stateVersion = "25.05"; # From myself: don't change this manually until you update the channel
}
