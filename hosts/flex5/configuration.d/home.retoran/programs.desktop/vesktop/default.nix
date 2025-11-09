{ pkgs, ... }: {
  # Vesktop has a programs.vesktop implementation. Should use that instead.
  home.packages = with pkgs; [
    vesktop
  ];
}
