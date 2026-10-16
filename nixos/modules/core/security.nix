{ pkgs, lib, ... }:

{
  security = {
    audit.enable = true;
    auditd.enable = true;

    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };

    polkit.enable = true;

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

  boot.kernel.sysctl = {
    # Hide kernel pointers and logs from unprivileged users
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;

    # BPF
    "kernel.unprivileged_bpf_disabled" = 1;
    "net.core.bpf_jit_harden" = 2;

    # Ignore ICMP redirects, don't send them
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
  };

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      mpv = {
        executable = "${pkgs.mpv}/bin/mpv";
        profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
        extraArgs = [
          "--net=none"
          "--noroot"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    apparmor-utils
    policycoreutils
  ];

  environment.defaultPackages = [ ];
}
