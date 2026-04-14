{ ... }:
{
  imports = [
    ./../../../modules/nixos/default.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "flex5-retoran";
}
