{ lib, ... }:
{
  security = {
    # Additional Security Measures
    audit.enable = true;
    auditd.enable = true;

    sudo.enable = true;
    sudo.wheelNeedsPassword = true;

    lsm = lib.mkForce [
      "landlock"
      "lockdown"
      "yama"
      "integrity"
    ];
  };
}
