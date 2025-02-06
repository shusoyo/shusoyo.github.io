---
title: Nixos in Software Inovation Studio
date: 2025-01-07
tags:
  - Nixos
---

## Nix flake

The first thing is `nix flake`, a experiment feature. I use a flake based repo to organize all of my machine, and can specific the version using hash.

## Nix Anywhere

I using `nix-anywhere` to install nixos in the HP 877E.

```txt
typer@sis
--------- 
OS: NixOS 25.05.20250116.5df4362 (Warbler) x86_64
Host: HP 877E
Kernel: 6.6.71
Uptime: 3 days, 5 hours, 13 mins 
Packages: 332 (nix-system), 420 (nix-user) 
Shell: fish 3.7.1
Resolution: 1440x900
Terminal: /dev/pts/0
CPU: Intel i7-10700 (16) @ 4.800GHz 
GPU: Intel CometLake-S GT2 [UHD Graphics 630] 
Memory: 775MiB / 15821MiB
```

Nix Anywhere use `disko` to part disk.

## Network

``` nix
networking = {
  hostName    = "sis";
  useDHCP     = false;
  useNetworkd = true;
  nameservers = [ "223.6.6.6" "8.8.8.8" ];

  firewall.enable = false; # No local firewall
};

services.resolved = {
  enable  = true;
  domains = [ "~." ];
  fallbackDns = [ "223.5.5.5" "8.8.8.8" ];
  extraConfig = ''
    DNSStubListenerExtra=10.0.0.1
    MulticastDNS=no
  '';
};

systemd.network.enable = true;
systemd.network.networks."50-usb-RNDIS" = {
  matchConfig.Name = "enp0s20f0*";
  DHCP = "yes";
  dhcpV4Config = {
    RouteMetric = 100;
  };
};

systemd.network.networks."10-enp1s0" = {
  matchConfig.Name = "enp1s0";

  address = [ "10.85.13.10/25" ];

  routes  = [
    { Gateway = "10.85.13.1"; Metric = 300; }
  ];

  networkConfig = {
    DHCPServer = "yes";
  };

  dhcpServerConfig = {
    ServerAddress = "10.0.0.1/24";
    PoolOffset = 20;
    PoolSize   = 30;
    DNS = [ "10.0.0.1" ];
  };

  dhcpServerStaticLeases = [
    # ap
    { MACAddress = "5c:02:14:9e:d6:dd"; Address = "10.0.0.2";  }
    # ss
    { MACAddress = "00:e2:69:6e:2c:ed"; Address = "10.0.0.10"; }
  ];
};

networking.nftables = {
  enable = true;
  rulesetFile = ./asserts/ruleset.nft;
};
```

### Nftables ruleset

```txt
table ip sharing {
  chain postrouting {
    type nat hook postrouting priority 100; policy accept;
    oifname "enp0s20f0u5" masquerade
  }

  chain input {
    type filter hook input priority 0; policy accept;
    iifname "enp1s0" accept
  }
}
```

## Iot device: HP laserJet printer

```nix
# Mdns
services.avahi = {
  enable       = true;
  nssmdns4     = true;
  openFirewall = true;

  publish = {
    enable       = true;
    userServices = true;
  };
};

# Printer (HP LaserJet_Professional P1106 at sis2)
services.printing = {
  enable  = true;
  drivers = [ pkgs.hplipWithPlugin ];

  listenAddresses = [ "*:631" ];
  allowFrom       = [ "all" ];
  browsing        = true;
  defaultShared   = true;
  openFirewall    = true;

  extraConf = ''
    DefaultEncryption Never
  '';
};
```

Use `NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin --run 'sudo -E hp-setup -i'` to setup HP LaserJet Professional P1106.
