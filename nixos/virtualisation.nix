{ pkgs, ... }:
{
  # KVM/QEMU virtualization support
  programs.virt-manager.enable = true;

  # UEFI Support
  # systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
    docker = {
      enable = true;
      # Enable Docker daemon on boot
      enableOnBoot = true;
      # Add support for non-root users to use Docker
      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      # };
    };
  };

  environment.systemPackages = with pkgs; [
    OVMF
    qemu_full
    virtiofsd

    # SPICE-related packages for virtual machine support
    spice-gtk
    spice-protocol
    spice-vdagent

    # Docker-related tools
    docker-compose # Replace podman-compose
    docker-client # Docker CLI tools
    lazydocker # Terminal UI for Docker
  ];

  # USB redirection for SPICE
  virtualisation.spiceUSBRedirection.enable = true;

  systemd.tmpfiles.rules =
    let
      firmware = pkgs.runCommandLocal "qemu-firmware" { } ''
        mkdir $out
        cp ${pkgs.qemu}/share/qemu/firmware/*.json $out
        substituteInPlace $out/*.json --replace ${pkgs.qemu} /run/current-system/sw
      '';
    in
    [ "L+ /var/lib/qemu/firmware - - - - ${firmware}" ];
}
