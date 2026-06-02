{ ... }:
{
  imports = [
    ./../../../modules/nixos
    ./../../../modules/nixos/configuration.d/obs-studio-virtualCamera.nix
    ./../../../modules/nixos/configuration.d/docker.nix
    ./hardware-configuration.nix
    ./boot.nix
  ];
  networking.hostName = "desktop-retoran";
  systemd.network.online.wifiRequired = false;
  systemd.network.online.ethernetRequired = true;
}
