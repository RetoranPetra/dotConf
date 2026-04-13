{ pkgs, lib, ... }:
let
  # This just adds a script to our bin to easily enroll TPM2 to our root.
  luksEnrollTPM = pkgs.writeTextFile {
    name = "luksEnrollTPM";
    destination = "/bin/luksEnrollTPM";
    executable = true;
    text = "systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+7 /dev/nvme1n1p2";
  };
in
# Enroll TPM2 keys with systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrs=0+7 /dev/disk/by-uuid/2611-2EA3
{
  environment.systemPackages = [
    luksEnrollTPM
    pkgs.sbctl
    # Needed for TPM2 key enrollment with systemd-cryptenroll
    pkgs.tpm2-tss
  ];

  # Forcefully disable systemd-boot in favour of lanzaboote
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
  boot.kernelModules = [
    "dm-snapshot"
    "tpm2-tss"
  ];
  boot.initrd.systemd = {
    enable = true;
    tpm2.enable = true;
  };
}
