{ ... }:

{
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [
      9998
    ];
    allowedTCPPorts = [
      5500
      9998
    ];

    # checkReversePath = false;
    trustedInterfaces = [ "virbr0" ];
  };
}
