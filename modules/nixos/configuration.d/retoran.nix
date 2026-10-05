{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--optimise -K 3d -k 3";
      dates = "daily";
    };
  };

  users.users.retoran = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "openrazer"
    ];
    shell = pkgs.zsh;
  };
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    protontricks.enable = true;
  };
  programs.gamescope.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
    font-awesome

    # Foreign fonts
    source-han-sans
  ];
  security.polkit.enable = true;
}
