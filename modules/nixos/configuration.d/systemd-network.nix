{
  config,
  libs,
  pkgs,
  lib,
  ...
}:
let cfg = config.systemd.network; in
with lib;
{
  options = {
    systemd.network.online.wifiRequired = mkOption {
      type = types.bool;
      default = false;
    };
    systemd.network.online.ethernetRequired = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = {
    networking.useDHCP = false;

    systemd.network.enable = true;
    systemd.network.networks."20-wired" = {
      matchConfig.Name = "en*";
      networkConfig.DHCP = "yes";
      dhcpV4Config = {
        # Don't use DNS from DHCP
        UseDNS = false;
        RouteMetric = 19;
      };
      ipv6AcceptRAConfig.RouteMetric = 20;
      linkConfig.RequiredForOnline = cfg.online.ethernetRequired;
    };
    systemd.network.networks."30-wireless" = {
      matchConfig.Name = "wl*";
      networkConfig.DHCP = "yes";
      dhcpV4Config = {
        # Don't use DNS from DHCP
        UseDNS = false;
        RouteMetric = 29;
      };
      ipv6AcceptRAConfig.RouteMetric = 30;
      linkConfig.RequiredForOnline = cfg.online.wifiRequired;
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

    services.resolved = {
      enable = true;
      settings.Resolve = {
        Domains = ["~."];
        FallbackDns = [
          "8.8.8.8#dns.google"
          "1.1.1.1#cloudflare-dns.com"
          "2620:fe::9#dns.quad9.net"
          "2606:4700:4700::1111#cloudflare-dns.com"
          "2001:4860:4860::8888#dns.google"];
        # Defaults
        DNSSEC = false;
        Cache = true;
        CacheFromLocalHost = false;
        DNSStubListener = true;
        ReadEtcHosts = true;
        DNSOverTLS = false;
        LLMNR = true;
      };
    };

    networking.nameservers = [
      "9.9.9.9#dns.quad9.net"
    ];
  };
}
