{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    waybar
    hyprland
    rofi-wayland
    mako
    grim
    slurp
    wl-clipboard
    hyprpolkitagent
    hyprpaper
    qt5.qtwayland
    qt6.qtwayland
    handlr
    btop-rocm
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-hyprland
    ];
    #configPackages = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-kde ];
    config.Hyprland = {
      default = [ "hyprland" "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = "kde";
    };
  };
  programs.zsh = { sessionVariables = { "GTK_USE_PORTAL" = 1; }; };

  xdg.configFile."hypr/waybar".source =
    /etc/nixos/home.retoran/home/retoran/.config/hypr/waybar;
  xdg.configFile."hypr/scripts".source =
    /etc/nixos/home.retoran/home/retoran/.config/hypr/scripts;
  xdg.configFile."hypr/hyprpaper.conf".source =
    /etc/nixos/home.retoran/home/retoran/.config/hypr/hyprpaper.conf;
  xdg.configFile."rofi".source =
    /etc/nixos/home.retoran/home/retoran/.config/rofi;

  xdg.configFile."uwsm/env".source =
    "/etc/profiles/per-user/retoran/etc/profile.d/hm-session-vars.sh";
  wayland.windowManager.hyprland = {
    package = null;
    #portalPackage = null;
    enable = true;
    settings = {
      # Global settings
      "$mainMod" = "SUPER";
      "$file" = "xdg-open ~";
      "$taskmgr" = "alacritty --class floating -T btop -e btop";

      "exec-once" = [
        "$exec waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css"
      ];
      "exec" = [
        "$exec /etc/nixos/home.retoran/home/retoran/.config/hypr/scripts/hyprGamemode.sh"
        "xrandr --output eDP-1 --primary"
      ];
      input = {
        # Should sync this keyboard options with xkb, as a global option somewhere.
        kb_layout = "gb";
        kb_options = "caps:escape";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0;
        repeat_rate = 25;
      };
      cursor.no_warps = true;
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 2;
        shadow.enabled = false;
        blur.size = 2;
      };
      animations = { enabled = true; };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = true;
      };
      misc = {
        mouse_move_enables_dpms = true;
        disable_splash_rendering = true;
      };
      # set false for debug.
      debug.disable_logs = true;
      # 00_monitors
      "monitor" = [ "eDP-1,1920x1080@60, 0x0, 1" ",preferred,auto,auto" ];
      "workspace" = [
        "1,monitor:eDP-1"
        "2,monitor:eDP-1"
        "3,monitor:eDP-1"
        "4,monitor:eDP-1"
        "5,monitor:eDP-1"
      ];
      "bind" = [
        # Navigation bindings
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"
        # Switch to workspace
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        # Move to active workspace
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        # Move to workspace and focus
        "$mainMod SHIFT CONTROL, 1, movetoworkspace, 1"
        "$mainMod SHIFT CONTROL, 2, movetoworkspace, 2"
        "$mainMod SHIFT CONTROL, 3, movetoworkspace, 3"
        "$mainMod SHIFT CONTROL, 4, movetoworkspace, 4"
        "$mainMod SHIFT CONTROL, 5, movetoworkspace, 5"
        "$mainMod SHIFT CONTROL, 6, movetoworkspace, 6"
        "$mainMod SHIFT CONTROL, 7, movetoworkspace, 7"
        "$mainMod SHIFT CONTROL, 8, movetoworkspace, 8"
        "$mainMod SHIFT CONTROL, 9, movetoworkspace, 9"
        "$mainMod SHIFT CONTROL, 0, movetoworkspace, 10"

        # scroll through workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, C, killactive"
        "$mainMod SHIFT, M, exec, sleep 1 && loginctl terminate-user ''"

        "$mainMod, Space, togglefloating"
        "$mainMod, F, fullscreen"

        # Execution bindings
        "$mainMod, Q, exec, uwsm app -- alacritty"
        "$mainMod SHIFT, Q, exec, uwsm app -- alacritty --class floating"
        "$mainMod, E, exec, uwsm app -- $file"
        ''
          $mainMod, R, exec, rofi -show drun -run-command "uwsm app -- {cmd}"''
        "$mainMod, S, exec, rofi -show window"
        "CTRL_SHIFT, escape, exec, uwsm app -- alacritty --class floating -T btop -e btop"
        ''
          ,Print, exec, grim -g "$(slurp)" | wl-copy && notify-send Grim "Snapped Segment"''
        ''
          CTRL, Print, exec, grim -o "$(hyprctl monitors -j | jaq -r '.[] | select(.focused).name')" | wl-copy && notify-send Grim "Snapped Monitor"''
        "$mainMod, N, exec, ~/.config/hypr/scripts/hyprGamemode.sh"

        # Media bindings
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -1 1.0 @DEFAULT_AUDIO_SINK@ 1%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -1 1.0 @DEFAULT_AUDIO_SINK@ 1%-"
        ",XF86AudioMute, exec, wpctl set-mute -1 1.0 @DEFAULT_AUDIO_SINK@ toggle"

      ];
      "bindm" = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
