{ ... }:
{
  imports = [
    ./../../../modules/nixos/default.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "desktop-retoran";
}
