{ pkgs, ... }: {
  # Vesktop has a programs.vesktop implementation. Should use that instead.
  xdg.configFile."vesktop" = {
    source = ./config;
    recursive = true;
  };
  home.packages = with pkgs; [
    vesktop
  ];
}
