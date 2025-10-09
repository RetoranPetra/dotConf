let
  mod = a: b: a - (b * (a / b));
in
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
    jaq
    xorg.xwininfo
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
  programs.zsh = {
      sessionVariables = { "GTK_USE_PORTAL" = 1; };
      loginExtra =
      ''
        TTY=$(ps -p $$ -o tty=)
        if [[ $TTY == "tty1" ]] && uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
        fi
      '';
    };
  programs.alacritty.enable = true;

  xdg.configFile."mako".source = ./mako;
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  xdg.configFile."rofi".source = ./rofi;

  xdg.configFile."uwsm/env".source = config.lib.file.mkOutOfStoreSymlink
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
        "$exec waybar -c ${builtins.toString ./waybar/config.jsonc} -s ${builtins.toString ./waybar/style.css}"
      ];
      "exec" = [
        "$exec ${builtins.toString ./scripts/hyprGamemode.sh}"
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
      "bind" = 
        builtins.concatLists [
          [
            # Navigation bindings
            "$mainMod, h, movefocus, l"
            "$mainMod, j, movefocus, d"
            "$mainMod, k, movefocus, u"
            "$mainMod, l, movefocus, r"
          ]
          # Workspace bindings 0 to 9
          (map (x: "$mainMod, ${builtins.toString (mod x 10)}, workspace, ${builtins.toString x}") [ 1 2 3 4 5 6 7 8 9 10 ])
          (map (x: "$mainMod SHIFT, ${builtins.toString (mod x 10)}, movetoworkspacesilent, ${builtins.toString x}") [ 1 2 3 4 5 6 7 8 9 10 ])
          (map (x: "$mainMod SHIFT CONTROL, ${builtins.toString (mod x 10)}, movetoworkspace, ${builtins.toString x}") [ 1 2 3 4 5 6 7 8 9 10 ])
          [
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
            "$mainMod, N, exec, ${builtins.toString ./scripts/hyprGamemode.sh}"

            # Media bindings
            ",XF86AudioPlay, exec, playerctl play-pause"
            ",XF86AudioPrev, exec, playerctl previous"
            ",XF86AudioNext, exec, playerctl next"
            ",XF86AudioRaiseVolume, exec, wpctl set-volume -1 1.0 @DEFAULT_AUDIO_SINK@ 1%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume -1 1.0 @DEFAULT_AUDIO_SINK@ 1%-"
            ",XF86AudioMute, exec, wpctl set-mute -1 1.0 @DEFAULT_AUDIO_SINK@ toggle"
          ]
        ];
      "bindm" = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
