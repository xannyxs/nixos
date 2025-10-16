{ ... }:

{
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [
      8085
      # 53317
    ];
    allowedTCPPorts = [
      8085
      # 53317
    ];
  };
}
