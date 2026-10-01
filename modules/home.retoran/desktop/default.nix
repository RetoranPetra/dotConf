{
  lib,
  ...
}:
{
  options.retoran.desktop.enable = lib.mkDefault true;
  imports = [
    ./hyprland
    ./fcitx5.nix
    ./handlr.nix
    ./theme.nix
    ./wayland.nix
  ];
}
