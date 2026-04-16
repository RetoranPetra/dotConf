{ ... }:
{
  imports = [
    ./../../../modules/nixos/default.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "flex5-retoran";
  systemd.network.online.wifiRequired = true;
  systemd.network.online.ethernetRequired = false;
}
