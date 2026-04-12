{ config, lib, pkgs, home-manager,  ... }: {

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
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  fonts.packages = with pkgs; [ nerd-fonts.iosevka-term nerd-fonts.iosevka ];
}
