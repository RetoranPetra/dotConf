# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      ./configuration.d
    ];

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;


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

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;


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


    # Linking existing .dotconf files
    xdg.configFile."nvim".source = /etc/nixos/home.retoran/home/retoran/.config/nvim;
    xdg.configFile."btop".source = /etc/nixos/home.retoran/home/retoran/.config/btop;
    xdg.configFile."gallery-dl".source = /etc/nixos/home.retoran/home/retoran/.config/gallery-dl;
    xdg.configFile."yt-dlp.conf".source = /etc/nixos/home.retoran/home/retoran/.config/yt-dlp.conf;
    xdg.configFile."mako".source = /etc/nixos/home.retoran/home/retoran/.config/mako;
    # Vesktop has a programs.vesktop implementation. Should use that instead.
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
      package = pkgs.fcitx5;
      fcitx5 = {
        addons = with pkgs; [ fcitx5-mozc ];
        settings = {
          globalOptions = {
            Hotkey = {
              EnumerateWithTriggerKeys = false;
              ModifierOnlyKeyTimeout = 250;
              TriggerKeys = {
                "0" = "Control+Alt+space";
                "1" = "Zenkaku_Hankaku";
                "2" = "Hangul";
              };
              ActivateKeys = {
                "0" = "Control+grave";
              };
              DeactivateKeys = {
                "0" = "Control-notsign";
              };
            };
          };
          inputMethod = {
            GroupOrder."0" = "Default";
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "gb";
              DefaultIM = "mozc";
            };
            "Groups/0/Items/0".Name = "keyboard-gb";
            "Groups/0/Items/1".Name = "mozc";
          };
        };
      };
    };

    home.packages = with pkgs; [

      # System utilities
      qdirstat
      helvum
      pulsemixer
      btop-rocm

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

  # System fonts
  fonts.packages = with pkgs; [
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

