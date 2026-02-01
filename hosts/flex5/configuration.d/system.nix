{ config, lib, pkgs, ... }: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; };

  # Set your time zone.
  time.timeZone = "Europe/London";
  services.ntp.enable = true;

  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };
  services.syncthing.enable = true;
  services.gvfs.enable = true;
}
