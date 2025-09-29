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
  xdg.configFile."mako".source =
    /etc/nixos/home.retoran/home/retoran/.config/mako;
  # Vesktop has a programs.vesktop implementation. Should use that instead.
  xdg.configFile."vesktop" = {
    source = /etc/nixos/home.retoran/home/retoran/.config/vesktop;
    recursive = true;
  };
  xdg.configFile."YouTube Music" = {
    source = "/etc/nixos/home.retoran/home/retoran/.config/YouTube Music";
    recursive = true;
  };
  home.file.".scripts".source = /etc/nixos/home.retoran/home/retoran/.scripts;
  home.file.".env".source = /etc/nixos/home.retoran/home/retoran/.env;
  home.file.".bin".source = /etc/nixos/home.retoran/home/retoran/.bin;

  home.packages = with pkgs; [
    # System utilities
    qdirstat
    helvum
    pulsemixer
    btop-rocm

    # Essentials
    mpv
    ffmpeg
    feh

    # Wine
    wineWowPackages.stable
    winetricks
    protontricks

    # Programs
    vesktop
    deluge-gtk
    mpv
    blender
    audacity
    krita
    chatterino2
    youtube-music
    tor-browser-bundle-bin
    firefox

    # CLI programs
    gallery-dl
    fping
    streamlink

    # Development tools that should NOT be put here but this is the fastest way to get neovim working.
    # clang_tools
  ];

  home.stateVersion = "25.05"; # From myself: don't change this manually until you update the channel
}
