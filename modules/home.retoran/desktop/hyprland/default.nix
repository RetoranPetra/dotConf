{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.retoran.desktop.hyprland;
in
with lib;
{
  options = {
    retoran.desktop.hyprland.primaryMonitor = mkOption {
      type = types.str;
      default = "DP-1";
    };
    retoran.desktop.hyprland.workspaces.game = mkOption {
      type = types.str;
      default = "5";
    };
    retoran.desktop.hyprland.workspaces.discord = mkOption {
      type = types.str;
      default = "6";
    };
    retoran.desktop.hyprland.jpOCR = lib.mkEnableOption "Japanese OCR";
  };
  imports = [
    ./hypridle
    ./waybar
  ];
  config = {
    retoran.desktop.wayland = true;
    home.packages = with pkgs; [
      hyprland
      mako
      grim
      slurp
      wl-clipboard
      qt5.qtwayland
      qt6.qtwayland
      btop-rocm
      jaq
      xwininfo
      playerctl
      xrandr
      notify-desktop
    ];
    services.hyprpolkitagent.enable = true;
    services.playerctld.enable = true;
    services.hyprpaper = {
      enable = true;
      settings.splash = false;
    };
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-hyprland
      ];
      #configPackages = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-kde ];
      config.Hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = "kde";
      };
    };
    home.sessionVariables = {
      "GTK_USE_PORTAL" = 1;
      "GRIM_DEFAULT_DIR" = "/home/retoran/Pictures/grim";
    };
    programs.zsh = {
      loginExtra = ''
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

    xdg.configFile."uwsm/env".source = config.lib.file.mkOutOfStoreSymlink "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh";
    wayland.windowManager.hyprland = {
      package = null;
      #portalPackage = null;
      enable = true;

      # Disable systemd integration from home manager to prevent conflict with UWSM.
      systemd.enable = false;

      extraConfig = lib.strings.concatStrings [
        """
          local screenshotSegment = \"${toString ./scripts/screenshotSegment.sh}\"
          local screenshotDisplay = \"${toString ./scripts/screenshotDisplay.sh}\"
        """
        (builtins.readFile ./hyprland.lua)
        (if cfg.jpOCR then "" else "hl.bind(mainMod .. \" + A\", hl.dsp.exec_cmd(\"grim -g \\\"$(slurp)\\\" - | ${pkgs.tesseract}/bin/tesseract - - -l jpn+eng | sed 's/ //g' | wl-copy\"))")
      ];
      configType = "lua";
    };
  };
}
