{ pkgs, ... }:
{
#  xdg.configFile."YouTube Music" = {
#    source = "./../../../../../root/home/retoran/.config/YouTube Music";
#    recursive = true;
#  };
  home.packages = with pkgs; [
    # System Utils
    qdirstat
    crosspipe

    # Essential
    mpv
    feh

    # Misc
    deluge-gtk
    blender
    audacity
    krita
    pear-desktop
    tor-browser
    libreoffice

    # CAD
    librecad
    freecad
  ];
  services.syncthing.enable = true;

  # Also setup our mimeapps here as well.
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["thunar.desktop"];
        "inode/mount-point" = ["thunar.desktop"];
      };
    };
  };
}
