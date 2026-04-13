{ pkgs, ... }:
{
  # Enable razer hardware support
  hardware.openrazer.enable = true;

  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
}
