{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Wine
    wineWowPackages.stable
    winetricks
    protontricks
  ];
}
