{
  lib,
  ...
}:
{
  options.retoran.desktop.enable = lib.mkEnableOption "";
  imports = [
    ./hyprland
    ./fcitx5.nix
    ./handlr.nix
    ./theme.nix
    ./wayland.nix
  ];
}
