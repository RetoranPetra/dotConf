{
  lib,
  ...
}:
{
  options.retoran.desktop.enable = lib.mkOption {
    default = true;
    type = lib.types.bool;
  };
  imports = [
    ./hyprland
    ./fcitx5.nix
    ./handlr.nix
    ./theme.nix
    ./wayland.nix
  ];
}
