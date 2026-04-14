{ ... }:
{
  imports = [
    ./../../../modules/home.retoran/hyprland
  ];
  wayland.windowManager.hyprland = {
    workspaces.game = "5";
    workspaces.discord = "6";
    primaryMonitor = "eDP-1";
    settings = {
      "monitor" = [
        "eDP-1,1920x1080@60, 0x0, 1"
        ",preferred, auto, auto"
      ];
      "exec-once" = [
        "uwsm app -- vesktop.desktop"
        "[workspace 1 silent] uwsm app -- firefox.desktop"
      ];
    };
  };
  services.hyprpaper.settings.wallpaper = [
    {
      monitor = "eDP-1";
      path = "/home/retoran/Pictures/backgrounds/lucyBackgrounds/lucyIllustration.png";
    }
    {
      monitor = "";
      path = "/home/retoran/Pictures/backgrounds/lucyBackgrounds/lucyIllustration.png";
    }
  ];
}
