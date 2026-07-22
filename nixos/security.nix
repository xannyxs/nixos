{ pkgs, lib, ... }:

{
  security = {
    audit.enable = true;
    auditd.enable = true;

    sudo.enable = true;
    sudo.wheelNeedsPassword = true;

    protectKernelImage = true;

    apparmor = {
      enable = true;
      packages = [ pkgs.apparmor-profiles ];
    };

    lsm = lib.mkForce [
      "landlock"
      "apparmor"
      "yama"
      "bpf"
      "lockdown"
    ];
  };

  environment.systemPackages = [
    pkgs.apparmor-utils
  ];

  environment.defaultPackages = [ ];
}
