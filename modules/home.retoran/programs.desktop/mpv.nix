{ pkgs, ... }: {
  programs.mpv = {
    enable = true;
    scripts = [
      pkgs.mpvScripts.mpris
    ];
    config = {
      # This works, even though it's a bit funky.
      "save-position-on-quit" = "";
    };
  };
}
