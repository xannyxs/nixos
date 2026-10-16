{ pkgs, lib, ... }:

{
  # Secure Boot
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.initrd.systemd.enable = true;
  boot.lanzaboote.configurationLimit = 8;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    measuredBoot = {
      enable = false;
      # pcrs = [
      #   0
      #   4
      #   7
      # ];
    };
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  boot.kernelParams = [
    "quiet"
    "fbcon=nodefer"
    "vt.global_cursor_default=0"
    "spectre_v2=on"
    "spec_store_bypass_disable=on"
    "mds=full,nosmt"
    "mitigations=auto"
    "usbcore.autosuspend=-1"
    "usbhid.mousepoll=0"
    "amdgpu.abmlevel=1"
  ];

  boot.initrd.kernelModules = [
    "tpm_crb"
  ];

  environment.systemPackages = with pkgs; [
    sbctl
    tpm2-tools
    tpm2-tss
  ];
}
