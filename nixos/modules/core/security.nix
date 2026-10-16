{ pkgs, lib, ... }:

{
  security = {
    audit.enable = true;
    auditd.enable = true;

    sudo.enable = true;
    sudo.wheelNeedsPassword = true;

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

  services.fail2ban.enable = true;

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
