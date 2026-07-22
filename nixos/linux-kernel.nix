{ pkgs, lib, ... }:

{
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  boot.kernelParams = [
    "quiet"
    "fbcon=nodefer"
    "vt.global_cursor_default=0"
    "spectre_v2=on"
    "spec_store_bypass_disable=on"
    "mds=full,nosmt"
    "mitigations=auto"
    "ucsi_acpi.debug=1"
    "usbcore.autosuspend=-1"
    "usbhid.mousepoll=0"
  ];

  boot.initrd.kernelModules = [
    "tpm_crb"
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  nix.settings.allowed-users = [ "@wheel" ];
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  environment.systemPackages = with pkgs; [
    policycoreutils
    lsof
    iftop
    nmap
    clinfo
    mesa
    tpm2-tss
    firejail
    tcpdump
  ];

  services.fail2ban.enable = true;
}
