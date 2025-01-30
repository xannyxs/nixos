{ ... }:

{
  security.audit = {
    enable = true;
    backlogLimit = 8192;
  };

  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      #systemd-boot.enable = lib.mkForce false;
    };

    #lanzaboote = {
    # enable = true;
    #pkiBundle = "/etc/secureboot";
    #};
  };
}
