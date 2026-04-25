{
  config,
  lib,
  pkgs,
  ...
}:
{

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
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      proton-dw-bin
    ];
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
