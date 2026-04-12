{ pkgs, lib, ...}: {
  environment.systemPackages = [
    pkgs.sbctl
  ];

  # Forcefully disable systemd-boot in favour of lanzaboote
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
