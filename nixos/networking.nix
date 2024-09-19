{ ... }:

{
  # Enable networking
  networking.hostName = "saturn"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # networking = {
  #   bridges = {
  #     "br0" = {
  #       interfaces = [ "wlp4s0" ];
  #     };
  #   };
  #   interfaces = {
  #     br0.useDHCP = true;  # Or set a static IP if preferred
  #   };
  # };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
