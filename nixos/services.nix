{ pkgs, ... }:

{
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.usbmuxd.enable = true; # tmp
  security.polkit.enable = true;
  services.dbus.enable = true;
  services.upower.enable = true;
  services.fwupd.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  programs.nix-ld.enable = true;

  programs.zsh.enable = true;
  programs.java.enable = true;
  programs.neovim = {
    defaultEditor = true;
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    hunspell
    hunspellDicts.nl_nl
    hunspellDicts.en_GB-ize

    home-manager
    file-roller

    poweralertd
    playerctl

    libmtp

    # Java
    # jdk8
    # jdk17_headless
    jdk21_headless

    st
    quickemu # VM Launcher
    spice # VM Network
    qemu
    niv
  ];
}
