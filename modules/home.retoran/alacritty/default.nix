{
  programs.alacritty = {
    enable = true;
  };
  xdg.mimeApps.defaultApplications = {
    "x-xcheme-handler/terminal" = ["alacritty.desktop"];
  };
}
