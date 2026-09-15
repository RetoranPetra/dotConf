{ pkgs, ... }:
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
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    environmentVariables = {
      OLLAMA_KV_CACHE_TYPE = "q8_0";
    };
  };
  # Allow building aarch-64 binaries
  boot.binfmt.emulatedSystems = [ "aarch64-linux"];
  environment.systemPackages = [
    pkgs.dsh
  ];
}
