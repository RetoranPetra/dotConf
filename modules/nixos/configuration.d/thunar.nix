{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-volman
      thunar-media-tags-plugin

      # Archives
      thunar-archive-plugin
      #file-roller
      kdePackages.ark

      # Should put these archival plugins elsewhere
      p7zip
      rar
      unrar
      zip
      unzip
    ];
  };
  environment.systemPackages = with pkgs; [
    # Extra thumbnail packages
    webp-pixbuf-loader
    ffmpegthumbnailer
    papers
    freetype
    icoextract
    libgsf
    gnome-epub-thumbnailer
    totem
    icoextract
    f3d
    freetype
    totem
  ];
  services.tumbler.enable = true;
  programs.xfconf.enable = true;
}
