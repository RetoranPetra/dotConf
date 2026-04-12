{...}: {
  imports = [
    ./configuration.nix
    ./system.nix
    ./configuration.d/retoran.nix
    ./configuration.d/thunar.nix
    ./configuration.d/systemd-network.nix
    ./configuration.d/razer.nix
  ];
}
