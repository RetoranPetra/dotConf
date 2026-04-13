{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Wine
    wineWow64Packages.stable
    winetricks
  ];
}
