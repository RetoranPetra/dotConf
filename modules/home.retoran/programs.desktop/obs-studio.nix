{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
    # Virtual camera support only works outside of home-manager, as it needs to set boot/kernel stuff.
    #enableVirtualCamera = true;
  };
}
