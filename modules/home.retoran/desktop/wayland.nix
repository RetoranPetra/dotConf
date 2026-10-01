{ lib, config, ... }:
{
  options.retoran.desktop.wayland.enable = lib.mkDefault true;
  config = lib.mkIf config.retoran.desktop.wayland.enable {
    # Environment variables for forcing wayland.
    # TODO: These should probably be moved to hyprland instead.
    home.sessionVariables = {
      "QT_QPA_PLATFORM" = "wayland;xcb";
      "SDL_VIDEODRIVER" = "wayland,x11,*";
      "PROTON_ENABLE_WAYLAND" = 1;

      # Keep these out for now, unsure what needs them.
      #"LIBVA_DRIVER_NAME" = "radeonsi";
      #"VDPAU_DRIVER" = "radeonsi";
      #VR Variable? Keeping from arch configuration, might not be needed.
      "WLR_DRM_DEVICES" = "/dev/dri/card1";
    };
  };
}
