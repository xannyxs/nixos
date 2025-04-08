{ ... }:

{
  # Enable networking
  networking = {
    hostName = "saturn";
    firewall.allowPing = false;
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
    };
  };

  /*
    services.zerotierone = {
    	  enable = true;
    	  joinNetworks = [
    		  "159924d63011441f"
    	  ];
      };
  */
}
