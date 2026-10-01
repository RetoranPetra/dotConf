{ pkgs, ... } : {
  services.hypridle.enable = true;
  home.packages = [
    pkgs.hyprlock
  ];
  xdg.configFile."hypr/hypridle.conf".source = ./hypridle.conf;
}

