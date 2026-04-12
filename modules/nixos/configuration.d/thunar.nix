{ config, lib, pkgs, ... }: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      xfce.thunar-volman
      xfce.thunar-media-tags-plugin
      xfce.tumbler
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
