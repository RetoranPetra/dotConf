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
