{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chatterino2
    streamlink
  ];
}
