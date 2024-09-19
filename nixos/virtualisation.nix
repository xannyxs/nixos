{...}:

{
  # dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = ["qemu:///system"];
  #     uris = ["qemu:///system"];
  #   };
  # };

  users.users.xannyx.extraGroups = [ "libvirtd" ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
