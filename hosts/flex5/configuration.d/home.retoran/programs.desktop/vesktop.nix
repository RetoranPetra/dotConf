{ pkgs, ... }:
{
  # Vesktop has a programs.vesktop implementation. Should use that instead.
  xdg.configFile."vesktop" = {
    source = ./../../../../../root/home/retoran/.config/vesktop;
    recursive = true;
  };
  home.packages = with pkgs; [
    vesktop
  ];
}
