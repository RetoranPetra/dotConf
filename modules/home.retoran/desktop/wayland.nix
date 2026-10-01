{ ... }:
{
  # Environment variables for forcing wayland.
  home.sessionVariables = {
    # TODO: Copy FCITX5 environment variables to wherever the FCITX5 setup is.
    "QT_QPA_PLATFORM" = "wayland;xcb";
    "SDL_VIDEODRIVER" = "wayland,x11,*";
    "PROTON_ENABLE_WAYLAND" = 1;

    # Keep these out for now, unsure what needs them.
    #"LIBVA_DRIVER_NAME" = "radeonsi";
    #"VDPAU_DRIVER" = "radeonsi";
    #VR Variable? Keeping from arch configuration, might not be needed.
    "WLR_DRM_DEVICES" = "/dev/dri/card1";
  };
}
