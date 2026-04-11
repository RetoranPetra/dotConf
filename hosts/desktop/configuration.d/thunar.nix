{ config, lib, pkgs, ... }: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      xfce.thunar-volman
      xfce.thunar-media-tags-plugin
      xfce.tumbler
      ffmpegthumbnailer
    ];
  };
}
