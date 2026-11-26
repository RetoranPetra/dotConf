{ pkgs, ... }:
{
  imports = [
    ./../../../modules/nixos
    ./../../../modules/nixos/configuration.d/obs-studio-virtualCamera.nix
    ./../../../modules/nixos/configuration.d/docker.nix
    ./virtualisation.nix
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
  services.preload-ng = {
    enable = true;
    usePrecompiled = false;

    settings = {
      # Faster cycle times for NVMe responsiveness
      cycle = 16;
      # Track 1 MB min files
      minSize = 1000000;
      predictionAlgorithm = "Markov";
    };
  };
  # Allow building aarch-64 binaries
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  environment.systemPackages = [
    pkgs.dsh
  ];

  # Setup our steam gamescope
  programs.steam.gamescopeSession = {
    enable = true;
    args = [
      "-W 2560"
      "-H 1440"
      "-r 180"
      "-ef"
      "--adaptive-sync"
      "-O DP-1"
    ];
    steamArgs = [
      "-tenfoot"
    ];
  };
}
