{ ... }:
{
  imports = [
    ./../../../modules/nixos
    ./../../../modules/nixos/configuration.d/obs-studio-virtualCamera.nix
    ./hardware-configuration.nix
    ./boot.nix
  ];
  networking.hostName = "desktop-retoran";
  systemd.network.online.wifiRequired = false;
  systemd.network.online.ethernetRequired = true;
}
