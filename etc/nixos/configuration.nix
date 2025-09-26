# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "flex5-retoran"; # Define your hostname.
  networking.useDHCP = false;
  networking.nftables.enable = true;
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  systemd.network.enable = true;
  systemd.network.networks."20-wired" = {
    matchConfig.Name = "en*";
    networkConfig.DHCP = "yes";
    dhcpV4Config.RouteMetric=19;
    ipv6AcceptRAConfig.RouteMetric=20;
    linkConfig.RequiredForOnline= "no";
  };
  systemd.network.networks."30-wireless" = {
    matchConfig.Name = "wl*";
    networkConfig.DHCP = "yes";
    dhcpV4Config.RouteMetric=29;
    ipv6AcceptRAConfig.RouteMetric=30;
    # linkConfig.RequiredForOnline= "no";
  };
  systemd.network.networks."90-tun-ignore" = {
    matchConfig.Name = "tun*";
    linkConfig.Unmanaged=true;
  };
  systemd.network.networks."91-pia-ignore" = {
    matchConfig.Name = "pia";
    linkConfig.Unmanaged = true;
  };
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = false;
    };
    Network = {
      NameResolvingService="systemd";
    };
  };


  # Set your time zone.
  time.timeZone = "Europe/London";
  services.ntp.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable preload
  services.preload = {
    enable = true;
  };

  # Enable tablet driver
  hardware.opentabletdriver.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.options = "caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };
  services.syncthing.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  home-manager.users.retoran = { pkgs, ... }: {
    home.sessionPath = [
      # Should probably move things from .bin to .local/bin
      "$HOME/.bin"
      "$HOME/.local/bin"
    ];
    # Git configuration
    programs.git = {
      enable = true;
      userEmail = "flyro@live.co.uk";
      userName = "RetoranPetra";
      extraConfig = {
        init.defaultBranch = "main";
        core = {
          editor = "nvim";
        };
        credential."https://github.com".helper = "!/usr/bin/env gh auth git-credential";
        credential."https://gist.github.com".helper = "!/usr/bin/env gh auth git-credential";
      };

      lfs.enable = true;
    };
    # This doesn't work
    /*
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
    */
    programs.lazygit = {
      enable = true;
    };
    programs.alacritty = {
      enable = true;
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
        terminal.shell = "zsh";
      };
    };
    programs.zsh = {
      enable = true;

      sessionVariables = {
        "GTK_USE_PORTAL" = 1;
      };
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      antidote = {
        enable = true;
        plugins = [
          "getantidote/use-omz"
          "ohmyzsh/ohmyzsh path:lib"

          "ohmyzsh/ohmyzsh path:plugins/gitfast"
          "ohmyzsh/ohmyzsh path:plugins/heroku"
          "ohmyzsh/ohmyzsh path:plugins/pip"
          #"ohmyzsh/ohmyzsh path:plugins/lein"
          "ohmyzsh/ohmyzsh path:plugins/command-not-found"

          "ohmyzsh/ohmyzsh path:plugins/fzf"
          #"ohmyzsh/ohmyzsh path:plugins/fd"

          "ohmyzsh/ohmyzsh path:plugins/gh"
          "ohmyzsh/ohmyzsh path:plugins/gitignore"
          "ohmyzsh/ohmyzsh path:plugins/golang"
          "ohmyzsh/ohmyzsh path:plugins/rust"
          "ohmyzsh/ohmyzsh path:plugins/dotnet"

          "ohmyzsh/ohmyzsh path:themes/af-magic.zsh-theme"

          #"zsh-users/zsh-syntax-highlighting"
          #"zsh-users/zsh-autosuggestions"
          #"zsh-users/zsh-completions"
        ];
      };
    };
    # Themeing
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

    xdg.configFile."uwsm/env".source = "/etc/profiles/per-user/retoran/etc/profile.d/hm-session-vars.sh"; 
    xdg.portal = {
      #enable = true;
      #extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
      config.hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        #org.freedesktop.impl.portal.FileChooser = "kde";
      };
    };
    wayland.windowManager.hyprland = {
      package = null;
      portalPackage = null;
      enable = true;
      settings = {
        # Global settings
        "$mainMod" = "SUPER";
        "$file" = "xdg-open ~";
        "$taskmgr" = "alacritty --class floating -T btop -e btop";

        "exec-once" = [
          "$exec waybar -c ~/.config/hypr/waybar/config.jsonc -s ~/.config/hypr/waybar/style.css"
        ];
        "exec" = [
          "$exec /etc/nixos/home.retoran/home/retoran/.config/hypr/scripts/hyprGamemode.sh"
          "xrandr --output eDP-1 --primary"
        ];
        input = {
          # Should sync this keyboard options with xkb, as a global option somewhere.
          kb_layout = "gb";
          kb_options = "caps:escape";
          numlock_by_default = true;
          follow_mouse = 1;
          sensitivity = 0;
          repeat_rate = 25;
        };
        cursor.no_warps = true;
        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 1;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
        };
        decoration = {
          rounding = 2;
          shadow.enabled = false;
          blur.size = 2;
        };
        animations = {
          enabled = true;
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
          smart_split = true;
        };
        misc = {
          mouse_move_enables_dpms = true;
          disable_splash_rendering = true;
        };
        # set false for debug.
        debug.disable_logs = true;
        # 00_monitors
        "monitor" = [
          "eDP-1,1920x1080@60, 0x0, 1"
          ",preferred,auto,auto"
        ];
        "workspace" = [
          "1,monitor:eDP-1"
          "2,monitor:eDP-1"
          "3,monitor:eDP-1"
          "4,monitor:eDP-1"
          "5,monitor:eDP-1"
        ];
        "bind" = [
          # Navigation bindings
          "$mainMod, h, movefocus, l"
          "$mainMod, j, movefocus, d"
          "$mainMod, k, movefocus, u"
          "$mainMod, l, movefocus, r"
          # Switch to workspace
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          # Move to active workspace
          "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
          "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
          "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
          # Move to workspace and focus
          "$mainMod SHIFT CONTROL, 1, movetoworkspace, 1"
          "$mainMod SHIFT CONTROL, 2, movetoworkspace, 2"
          "$mainMod SHIFT CONTROL, 3, movetoworkspace, 3"
          "$mainMod SHIFT CONTROL, 4, movetoworkspace, 4"
          "$mainMod SHIFT CONTROL, 5, movetoworkspace, 5"
          "$mainMod SHIFT CONTROL, 6, movetoworkspace, 6"
          "$mainMod SHIFT CONTROL, 7, movetoworkspace, 7"
          "$mainMod SHIFT CONTROL, 8, movetoworkspace, 8"
          "$mainMod SHIFT CONTROL, 9, movetoworkspace, 9"
          "$mainMod SHIFT CONTROL, 0, movetoworkspace, 10"

          # scroll through workspaces
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          "$mainMod, C, killactive"
          "$mainMod SHIFT, M, exec, sleep 1 && loginctl terminate-user ''"

          "$mainMod, Space, togglefloating"
          "$mainMod, F, fullscreen"

          # Execution bindings
          "$mainMod, Q, exec, uwsm app -- alacritty"
          "$mainMod SHIFT, Q, exec, uwsm app -- alacritty --class floating"
          "$mainMod, E, exec, uwsm app -- $file"
          "$mainMod, R, exec, rofi -show drun -run-command \"uwsm app -- {cmd}\""
          "$mainMod, S, exec, rofi -show window"
          "CTRL_SHIFT, escape, exec, uwsm app -- alacritty --class floating -T btop -e btop"
          ",Print, exec, grim -g \"$(slurp)\" | wl-copy && notify-send Grim \"Snapped Segment\""
          "CTRL, Print, exec, grim -o \"$(hyprctl monitors -j | jaq -r '.[] | select(.focused).name')\" | wl-copy && notify-send Grim \"Snapped Monitor\""
          "$mainMod, N, exec, ~/.config/hypr/scripts/hyprGamemode.sh"

          # Media bindings
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPrev, exec, playerctl previous"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -1 1.0 @DEFAULT_AUDIO_SINK@ 1%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume -1 1.0 @DEFAULT_AUDIO_SINK@ 1%-"
          ",XF86AudioMute, exec, wpctl set-mute -1 1.0 @DEFAULT_AUDIO_SINK@ toggle"

        ];
        "bindm" = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };

    # Linking existing .dotconf files
    xdg.configFile."nvim".source = /etc/nixos/home.retoran/home/retoran/.config/nvim;
    xdg.configFile."btop".source = /etc/nixos/home.retoran/home/retoran/.config/btop;
    xdg.configFile."gallery-dl".source = /etc/nixos/home.retoran/home/retoran/.config/gallery-dl;
    xdg.configFile."hypr/waybar".source = /etc/nixos/home.retoran/home/retoran/.config/hypr/waybar;
    xdg.configFile."hypr/scripts".source = /etc/nixos/home.retoran/home/retoran/.config/hypr/scripts;
    xdg.configFile."hypr/hyprpaper.conf".source = /etc/nixos/home.retoran/home/retoran/.config/hypr/hyprpaper.conf;
    xdg.configFile."rofi".source = /etc/nixos/home.retoran/home/retoran/.config/rofi;
    xdg.configFile."yt-dlp.conf".source = /etc/nixos/home.retoran/home/retoran/.config/yt-dlp.conf;
    xdg.configFile."mako".source = /etc/nixos/home.retoran/home/retoran/.config/mako;
    xdg.configFile."vesktop" = {
      source = /etc/nixos/home.retoran/home/retoran/.config/vesktop;
      recursive = true;
    };
    xdg.configFile."YouTube Music" = {
      source = "/etc/nixos/home.retoran/home/retoran/.config/YouTube Music";
      recursive = true;
    };
    home.file.".scripts".source = /etc/nixos/home.retoran/home/retoran/.scripts;
    home.file.".env".source = /etc/nixos/home.retoran/home/retoran/.env;
    home.file.".bin".source = /etc/nixos/home.retoran/home/retoran/.bin;

    i18n.inputMethod = {
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [ fcitx5-mozc ];
        settings = {
          inputMethod = {
            GroupOrder."0" = "Default";
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "gb";
            };
            "Groups/0/Items/0".Name = "keyboard-gb";
            "Groups/0/Items/1".Name = "mozc";
          };
        };
      };
    };

    home.packages = with pkgs; [
      # Hyprland needed packages
      waybar
      hyprland
      rofi-wayland
      mako
      grim
      slurp
      wl-clipboard
      hyprpolkitagent
      hyprpaper
      hyprcursor
      qt5.qtwayland
      qt6.qtwayland
      #Need to check how this gets configured properly.
      fcitx5

      # System utilities
      qdirstat
      helvum
      pulsemixer
      btop-rocm
      ## thunar
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-media-tags-plugin
      xfce.tumbler
      ffmpegthumbnailer

      # Essentials
      mpv
      ffmpeg
      feh
      gh

      # Wine
      wineWowPackages.stable
      winetricks
      protontricks

      # Programs
      vesktop
      deluge-gtk
      mpv
      blender
      audacity
      krita
      chatterino2
      youtube-music
      tor-browser-bundle-bin
      firefox

      # CLI programs
      gallery-dl
      fping
      streamlink

      # Development tools that should NOT be put here but this is the fastest way to get neovim working.
      # clang_tools
      python3
      nodejs
      llvmPackages_latest.clang
      llvmPackages_latest.libcxx
      llvmPackages_latest.libllvm
      llvmPackages_latest.lldb
      unzip
      go
      cmake
      gnumake
    ];

    home.stateVersion = "25.05"; # From myself: don't change this manually until you update the channel
  };
  users.users.retoran = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # System fonts
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka
    iosevka
    noto-fonts
    noto-fonts-cjk-sans
  ];

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    bat
    sccache
    rclone
    rsync
    lrzip
    traceroute
    xdg-user-dirs
    git
    git-lfs
    lazygit
    fzf
    fd
    jq
    jo
    strace
    tmux
    btop-rocm
    wireguard-tools
    ripgrep
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

