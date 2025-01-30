{ pkgs, ... }:

{
  # Linux Kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_lqx;

  boot.kernelParams = [
    "quiet"
    "fbcon=nodefer"
    "vt.global_cursor_default=0"
    "lsm=landlock,lockdown,yama,integrity"
    "security=apparmor"
    "spectre_v2=on"
    "spec_store_bypass_disable=on"
    "mds=full,nosmt"
    "mitigations=auto"
    "ucsi_acpi.debug=1"
    "usbcore.autosuspend=-1"
    "usbhid.mousepoll=0"
  ];

  boot.initrd.kernelModules = [
    "amdgpu"
    "tpm_crb"
  ];

  # services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Apparmor Configuration
  security.apparmor.enable = true;
  security.apparmor.packages = with pkgs; [
    apparmor-utils
    apparmor-profiles
  ];

  # Additional Security Measures
  security.audit.enable = true;
  security.auditd.enable = true;
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  # System Hardening
  # security.protectKernelImage = true;
  # security.lockKernelModules = true;
  # security.forcePageTableIsolation = true;

  # Package Management
  nix.settings.allowed-users = [ "@wheel" ];
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    apparmor-utils
    apparmor-profiles
    policycoreutils
    audit
    lsof
    htop
    iftop
    nmap
    clinfo
    mesa
    fail2ban
    tpm2-tss
    firejail
    tcpdump
  ];

  services.fail2ban.enable = true;
  services.fwupd.enable = true;
}
