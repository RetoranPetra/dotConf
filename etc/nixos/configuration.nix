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
    #programs.zsh = {
    #enable = true;
    #};
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

    home.packages = with pkgs; [
      # Hyprland needed packages
      waybar
      hyprland
      rofi-wayland
      mako
      alacritty
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
  # networking.firewall.enable = false;

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

