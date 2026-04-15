{ ... }:
{
  imports = [
    ./../../../modules/home.retoran/hyprland
  ];
  wayland.windowManager.hyprland = {
    workspaces.game = "5";
    workspaces.discord = "6";
    primaryMonitor = "DP-1";
    settings = {
      "monitor" = [
        "DP-1,2560x1440@180,0x0,1"
        "DP-2,2560x1440@120,-1440x0,1,transform,1"
        ",preferred,auto,auto"
      ];
      "exec-once" = [
        "uwsm app -- steam.desktop"
        "uwsm app -- vesktop.desktop"
        "[workspace 1 silent] uwsm app -- firefox.desktop"
      ];
      misc.vrr = 1;
    };
  };
  services.hyprpaper.settings.wallpaper = [
    {
      monitor = "DP-1";
      path = "/home/retoran/Pictures/backgrounds/lucyBackgrounds/lucyIllustration.png";
    }
    {
      monitor = "DP-2";
      path = "/home/retoran/Pictures/backgrounds/lucyBackgrounds/lucy_portrait.png";
    }
    {
      monitor = "";
      path = "/home/retoran/Pictures/backgrounds/lucyBackgrounds/lucyIllustration.png";
    }
  ];
  home.sessionVariables = {
    # Needed to stop VDPAU from falling back to NVIDIA by default on wayland
    "VDPAU_DRIVER" = "radeonsi";
    # Included just for completeness, not typically needed.
    "LIBVA_DRIVER_NAME" = "radeonsi";
  };
}
