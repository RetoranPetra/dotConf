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

      tumbler
      # Extra thumbnail packages
      ffmpegthumbnailer
      papers
      freetype
      icoextract
      libgsf
      gnome-epub-thumbnailer
      totem
    ];
  };
  programs.xfconf.enable = true;
}
