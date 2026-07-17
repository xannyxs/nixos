{ pkgs, ... }:
{
  programs.virt-manager.enable = true;
  boot.extraModprobeConfig = "options kvm_amd nested=1";

  # networking.bridges = {
  #   br0.interfaces = [ "eth0" ];
  # };
  #
  # networking.interfaces.br0 = {
  #   useDHCP = true;
  # };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  environment.systemPackages = with pkgs; [
    qemu_full
    virtiofsd

    # SPICE-related packages for virtual machine support
    spice-gtk
    spice-protocol
    spice-vdagent

    # Docker
    docker-compose
    docker-client
    lazydocker
  ];

  virtualisation.spiceUSBRedirection.enable = true;
}
