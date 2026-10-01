{
  programs.alacritty = {
    enable = true;
  };
  xdg.mimeApps.defaultApplications = {
    "x-xcheme-handler/terminal" = [ "alacritty.desktop" ];
  };
  xdg.configFile."xfce4/helpers.rc".text = "TerminalEmulator=alacritty";

  # A lot of programs respect this surprisingly.
  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "alacritty.desktop" ];
  };
}
