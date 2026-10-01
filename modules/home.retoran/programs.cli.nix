{ pkgs, ... }:
{
  xdg.configFile."btop".source = ./../../root/home/retoran/.config/btop;

  home.packages = with pkgs; [
  ];
}
