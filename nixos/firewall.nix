{ ... }:

{
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [
      # 8085
      # 53317
    ];
    allowedTCPPorts = [
      # 8085
      # 53317
    ];

    # checkReversePath = false;
    trustedInterfaces = [ "virbr0" ];
  };

  # services.zerotierone = {
  #   enable = true;
  #   joinNetworks = [
  #     "159924d63011441f"
  #   ];
  # };
  # }
  # works = [
  #     "159924d63011441f"
  #   ];
  # };
}
