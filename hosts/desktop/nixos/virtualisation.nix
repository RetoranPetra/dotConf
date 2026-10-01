{pkgs, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };
  programs.virt-manager.enable = true;
  users.users.retoran.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    dnsmasq
  ];
  networking = {
    firewall = {
      trustedInterfaces = [ "virbr0" ];
    };
    # Nat was the thing that got networking working.
    nat = {
      enable = true;
      enableIPv6 = true;
      internalInterfaces = [ "virbr0" ];
    };
  };
}
