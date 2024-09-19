{ config, pkgs, ... }:

{
  # Linux Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernelParams = [ 
    "quiet"
    "fbcon=nodefer"
    "vt.global_cursor_default=0"
    "lsm=landlock,lockdown,yama,integrity,selinux"
    "security=selinux"
    "spectre_v2=on"
    "spec_store_bypass_disable=on"
    "mds=full,nosmt"
    "mitigations=auto"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # SELinux Configuration
  # security.selinux.enable = true;
  # security.selinux.type = "strict";
  systemd.package = pkgs.systemd.override { withSelinux = true; };

  # Additional Security Measures
  security.audit.enable = true;
  security.auditd.enable = true;
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  # System Hardening
  # security.hideProcessInformation = true;
  # security.lockKernelModules = true;
  security.protectKernelImage = true;

  # Package Management
  nix.settings.allowed-users = [ "@wheel" ];
  nix.settings.trusted-users = [ "root" "@wheel" ];

  # System Packages
  environment.systemPackages = with pkgs; [
    policycoreutils
    audit
    lsof
    htop
    iftop
    nmap
    clinfo
    tcpdump
    amdvlk
    fail2ban
    mesa
  ];

  services.fail2ban.enable = true;

  # Ensure filesystem is labeled for SELinux (do this only once!!!!!!!!)
  # boot.kernelParams = [ "autorelabel=1" ];

  # Time synchronization
  services.timesyncd.enable = true;
}
