{ config, lib, pkgs, ... }:
let
  mod = a: b: a - (b * (a / b));
  playerctlCmd = "playerctl --player=mpv,%any,chromium,firefox";
  cfg = config.wayland.windowManager.hyprland;
in
with lib;
{
  options = {
    wayland.windowManager.hyprland.primaryMonitor = mkOption {
      type = types.str;
      default = "DP-1";
    };
    wayland.windowManager.hyprland.workspaces.game = mkOption {
      type = types.str;
      default = "5";
    };
    wayland.windowManager.hyprland.workspaces.discord = mkOption {
      type = types.str;
      default = "6";
    };
  };
  imports = [
    ./../wayland.nix
  ];
  config = {
    home.packages = with pkgs; [
      waybar
      hyprland
      mako
      grim
      slurp
      wl-clipboard
      hyprpolkitagent
      hyprpaper
      qt5.qtwayland
      qt6.qtwayland
      handlr-regex
      btop-rocm
      jaq
      xwininfo
      playerctl
      xrandr
    ];
    services.playerctld.enable = true;

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
    home.sessionVariables = {
        "GTK_USE_PORTAL" = 1;
        "GRIM_DEFAULT_DIR" = "/home/retoran/Pictures/grim";
    };
    programs.zsh = {
        loginExtra =
        ''
          TTY=$(ps -p $$ -o tty=)
          if [[ $TTY == "tty1" ]] && uwsm check may-start; then
            exec uwsm start hyprland-uwsm.desktop
          fi
        '';
      };
    programs.alacritty.enable = true;

    programs.rofi = {
        enable = true;
        package = pkgs.rofi;
        theme = "${pkgs.rofi}/share/rofi/themes/Arc-Dark.rasi";
        modes = [
          "drun"
          "window"
        ];
    };

    xdg.configFile."mako".source = ./mako;
    xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    # xdg.configFile."rofi".source = ./rofi;

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
          "uwsm app -- waybar -c ${builtins.toString ./waybar/config.jsonc} -s ${builtins.toString ./waybar/style.css}"
        ];
        "exec" = [
          "${builtins.toString ./scripts/forcePrimary.bash} ${cfg.primaryMonitor}"
          "xrandr --output ${cfg.primaryMonitor} --primary"
          (builtins.toString ./scripts/hyprGamemode.sh)
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
        "workspace" = [
          "1,monitor:${cfg.primaryMonitor}"
          "2,monitor:${cfg.primaryMonitor}"
          "3,monitor:${cfg.primaryMonitor}"
          "4,monitor:${cfg.primaryMonitor}"
          "5,monitor:${cfg.primaryMonitor}"
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
              "$mainMod SHIFT, F, fullscreen, 1"

              # Execution bindings
              "$mainMod, Q, exec, uwsm app -- alacritty"
              "$mainMod SHIFT, Q, exec, uwsm app -- alacritty --class floating"
              "$mainMod, E, exec, uwsm app -- $file"
              "$mainMod, R, exec, rofi -show drun -run-command \"uwsm app -- {cmd}\""
              "$mainMod, S, exec, rofi -show window"
              "CTRL_SHIFT, escape, exec, uwsm app -- alacritty --class floating -T btop -e btop"
              ",Print, exec, grim -g \"$(slurp)\" | wl-copy && notify-send Grim \"Snapped Segment\""
              "CTRL, Print, exec, grim -o \"$(hyprctl monitors -j | jq -r '.[] | select(.focused).name')\" | wl-copy && notify-send Grim \"Snapped Monitor\""
              "$mainMod, N, exec, ${builtins.toString ./scripts/hyprGamemode.sh}"

              # Media bindings
              ",XF86AudioPlay, exec, ${playerctlCmd} play-pause"
              ",XF86AudioPause, exec, ${playerctlCmd} play-pause"
              ",XF86AudioStop, exec, ${playerctlCmd} stop"
              ",XF86AudioPrev, exec, ${playerctlCmd} previous"
              ",XF86AudioNext, exec, ${playerctlCmd} next"
              ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%+"
              ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 1%-"
              ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ]
          ];
        "bindm" = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        "windowrule" = [
          "float on, match:class ^floating$"
          "float on, match:class ^thunar$"
          "float on, size 720 1280, match:class ^(w|W)aydroid.*"
          "size 720 1280, match:class ^(w|W)aydroid.*"
          "float on, center on, size 1000 700, match:class ^org\.kde\.polkit-kde-authentication-agent-1$"
          "float on, center on, size 1000 700, match:class ^krita$, match:title - Krita"
          "float on, center on, size 1000 700, match:class ^xarchiver$"
          "float on, size 1000 700, center on, match:title ^(Save\ As|Open\ Files)$"
          "float on, size 1000 700, center on, match:class ^xdg-desktop-portal-gtk$"
          "float on, size 1000 700, center on, match:class ^org\.freedesktop\.impl\.portal\.desktop\.kde$"
          "float on, center on, size 1000 700, match:class ^(zenity|yad)$"
          # Haven't added warframe launcher or godot rules.

          # Workspace rules
          "workspace ${cfg.workspaces.game}, match:content game"
          "workspace ${cfg.workspaces.game}, match:class ^steam$"
          "workspace ${cfg.workspaces.discord}, match:class ^(WebCord|VencordDesktop|vesktop)$"
        ];
      };
    };
  };
}
