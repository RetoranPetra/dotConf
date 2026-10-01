{ pkgs, ... }: {
  home.packages = with pkgs; [
    waybar
  ];
  systemd.user.services.waybar-hypr = {
    Unit = {
      Description = "Hyprland specific waybar service";
      Documentation = "man:waybar(5)";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "exec";
      ExecCondition = "/run/current-system/sw/lib/systemd/systemd-xdg-autostart-condition \"Hyprland\" \"\" ";
      ExecStart = "${pkgs.waybar}/bin/waybar -c \"${toString ./config.jsonc}\" -s \"${toString ./style.css}\"";
      ExecReload = "kill -SIGUSR2 $MAINPID";
      Restart = "on-failure";
      Slice = "app-graphical.slice";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
