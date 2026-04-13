{
  config,
  libs,
  pkgs,
  ...
}:
{
  networking.useDHCP = false;

  systemd.network.enable = true;
  systemd.network.networks."20-wired" = {
    matchConfig.Name = "en*";
    networkConfig.DHCP = "yes";
    dhcpV4Config.RouteMetric = 19;
    ipv6AcceptRAConfig.RouteMetric = 20;
    linkConfig.RequiredForOnline = "no";
  };
  systemd.network.networks."30-wireless" = {
    matchConfig.Name = "wl*";
    networkConfig.DHCP = "yes";
    dhcpV4Config.RouteMetric = 29;
    ipv6AcceptRAConfig.RouteMetric = 30;
    # linkConfig.RequiredForOnline= "no";
  };
  systemd.network.networks."90-tun-ignore" = {
    matchConfig.Name = "tun*";
    linkConfig.Unmanaged = true;
  };
  systemd.network.networks."91-pia-ignore" = {
    matchConfig.Name = "pia";
    linkConfig.Unmanaged = true;
  };
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = false;
    };
    Network = {
      NameResolvingService = "systemd";
    };
  };

  # Firewall
  networking.nftables.enable = true;
  networking.firewall.enable = true;
}
