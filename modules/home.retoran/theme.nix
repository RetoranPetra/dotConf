{ pkgs, config, ... }:
{
    programs.alacritty = {
      theme = "nightfly";
      settings = {
        colors = {
          draw_bold_text_with_bright_colors = true;
          primary = {
            background = "#0D0F1C";
            foreground = "#acb4c2";
          };
        };
        cursor = {
          blink_interval = 500;
          blink_timeout = 0;
          thickness = 0.15;
          unfocused_hollow = false;
          style = {
            blinking = "on";
            shape = "Underline";
          };
          vi_mode_style = {
            blinking = "on";
            shape = "Underline";
          };
        };
        font = {
          size = 12.0;
          normal = {
            family = "Iosevkaterm NF";
            style = "Regular";
          };
        };
        window.opacity = 0.95;
      };
    };
    home.pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
    gtk = {
      enable = true;
      # Icon theme not respected for some reason. Might need to manually set in dconf.
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      theme = {
        #name = "Tokyonight";
        #package = pkgs.tokyonight-gtk-theme;
        name = "Materia-dark";
        package = pkgs.materia-theme;
      };
      gtk4.theme = config.gtk.theme;
      cursorTheme = {
        name = "Materia-dark";
        package = pkgs.materia-theme;
      };
      font = {
        name = "Sans";
        size = 11;
      };
    };
    qt = {
      enable = true;
      platformTheme.name = "gtk";
    };

    home.packages = with pkgs;
      [
        # Need to decide if this actually belongs in theming.
        # fcitx5-tokyonight
      ];
}
