{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.retoran.desktop.hyprland.idle.enable = lib.mkEnableOption {};
  config = lib.mkIf config.retoran.desktop.hyprland.idle.enable {
    services.hypridle.enable = true;
    home.packages = [
      pkgs.hyprlock
    ];
    xdg.configFile."hypr/hypridle.conf".source = ./hypridle.conf;
  };
}
