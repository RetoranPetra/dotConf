{ pkgs, ... }:
{
  xdg.configFile."autostart/steam.desktop".source = "${pkgs.steam}/share/applications/steam.desktop";
  xdg.configFile."autostart/firefox.desktop".source = "${pkgs.firefox}/share/applications/firefox.desktop";
  xdg.configFile."autostart/vesktop.desktop".source = "${pkgs.vesktop}/share/applications/vesktop.desktop";

  retoran.desktop.hyprland = {
    enable = true;
    workspaces.game = "5";
    workspaces.discord = "6";
    primaryMonitor = "DP-1";
    jpOCR = true;
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
