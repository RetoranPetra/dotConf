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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "flex5-retoran"; # Define your hostname.
  networking.useDHCP = false;
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  systemd.network.enable = true;
  systemd.network.networks."20-wired" = {
    matchConfig.Name = "en*";
    networkConfig.DHCP = "yes";
    dhcpV4Config.RouteMetric=19;
    ipv6AcceptRAConfig.RouteMetric=20;
  };
  systemd.network.networks."30-wireless" = {
    matchConfig.Name = "wl*";
    networkConfig.DHCP = "yes";
    dhcpV4Config.RouteMetric=29;
    ipv6AcceptRAConfig.RouteMetric=30;
    linkConfig.RequiredForOnline= "no";
  };
  systemd.network.networks."90-tun-ignore" = {
    matchConfig.Name = "tun*";
    linkConfig.Unmanaged=true;
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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;


  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.options = "caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.retoran = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      waybar
      hyprland
      alacritty
      kitty
      vesktop
      rofi-wayland
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-media-tags-plugin
      xfce.tumbler
      mako
      deluge-gtk
      mpv
      syncthing
      qdirstat
      helvum
      blender
      audacity
      feh
      fping
      ffmpeg
      gallery-dl
      grim
      slurp
      krita
      streamlink
      chatterino2
      youtube-music
      wl-clipboard
      tor-browser-bundle-bin

      # Unsure if this works
      ffmpegthumbnailer

      # Need to check how this gets integrated.
      fcitx5
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
#    extraPackages = with pkgs; [
#      python3
#      nodejs
#      llvmPackages_latest.clang
#      llvmPackages_latest.libcxx
#      llvmPackages_latest.libllvm
#      llvmPackages_latest.lldb
#      unzip
#    ];
  };

  # System fonts
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka
    iosevka
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
    gh
    git
    git-lfs
    lazygit
    fzf
    fd
    jq
    jo
    strace
    tmux
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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

