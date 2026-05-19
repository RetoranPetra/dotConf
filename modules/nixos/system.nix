{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NOTE: Override version 7.0.7 with 7.0.6 until there's a fix in 7.0.8/7.0.9 for our bluetooth issues.
  boot.kernelPackages =
    let
      # 7.0.6 only has zen1
      version = "7.0.6";
      suffix = "zen1";
    in
    pkgs.linuxPackagesFor (
      pkgs.linuxPackages_zen.kernel.override {
        inherit version suffix;
        modDirVersion = lib.versions.pad 3 "${version}-${suffix}";
        src = pkgs.fetchFromGitHub {
          owner = "zen-kernel";
          repo = "zen-kernel";
          rev = "v${version}-${suffix}";
          sha256 = "0b27mh7rndbyjbqf4gfivacgda9srkjlh1hdflasl0vq4sdy3d68";
        };
      }
    );
}
