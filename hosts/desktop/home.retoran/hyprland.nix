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
    };
  };
}
