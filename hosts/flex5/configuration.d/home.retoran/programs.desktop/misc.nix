{ pkgs, ... }:
{
#  xdg.configFile."YouTube Music" = {
#    source = "./../../../../../root/home/retoran/.config/YouTube Music";
#    recursive = true;
#  };
  home.packages = with pkgs; [
    # System Utils
    qdirstat
    helvum

    # Essential
    mpv
    feh

    # Misc
    deluge-gtk
    blender
    audacity
    krita
    youtube-music
    tor-browser-bundle-bin
  ];
}
