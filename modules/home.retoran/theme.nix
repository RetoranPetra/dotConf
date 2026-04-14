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
    name = "everforest-cursors-light";
    package = pkgs.everforest-cursors;
    size = 32;
  };
  gtk = {
    enable = true;
    iconTheme = {
      # This icon theme is actually misspelt, this is correct.
      name = "Everforest-Dark";
      package = pkgs.everforest-gtk-theme;
    };
    theme = {
      /*
        name = "Tokyonight-Dark";
        package = pkgs.tokyonight-gtk-theme;
      */
      name = "Materia-dark-compact";
      package = pkgs.materia-theme;
    };
    gtk4.theme = config.gtk.theme;
    font = {
      name = "Sans";
      size = 11;
    };
    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = 1;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  home.packages = with pkgs; [
    # Need to decide if this actually belongs in theming.
    # fcitx5-tokyonight

    # These are needed for GTK theme to be applied properly.
    qt6Packages.qt6gtk2
    libsForQt5.qtstyleplugins
  ];
}
