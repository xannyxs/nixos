{ ... }:

{
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [
      51820
      9993
    ];
    allowedTCPPorts = [
      51820
      9993
    ];
  };
}
