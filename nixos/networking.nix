{ config, ... }:

{
  services.tailscale.enable = true;
  services.resolved.enable = true;

  networking = {
    hostName = "saturn";
    nftables.enable = true;

    firewall = {
      allowPing = false;
      # trustedInterfaces = [ config.services.tailscale.interfaceName ];
      # allowedUDPPorts = [ config.services.tailscale.port ];
    };
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.macAddress = "random";
    };
  };

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
}
