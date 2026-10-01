{pkgs, ...}: {
  home.packages = with pkgs; [
    retroarch-full
  ];
}
