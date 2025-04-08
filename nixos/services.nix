{ pkgs, ... }:

{
  # Enable Services
  security.polkit.enable = true;
  services.dbus.enable = true;
  services.upower.enable = true;
  services.fwupd.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  programs.nix-ld.enable = true;

  # Mullvad
  # networking.resolvconf.enable = false;
  # services.resolved.enable = true;
  # networking.wireguard.enable = true;
  # networking.iproute2.enable = true;
  # services.mullvad-vpn.enable = true;

  programs.zsh.enable = true;
  programs.java.enable = true;
  programs.neovim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
    neovim

    hunspell
    hunspellDicts.nl_nl
    hunspellDicts.en_GB-ize

    home-manager
    file-roller

    # mullvad
    # mullvad-vpn

    poweralertd
    playerctl

    # Java
    jdk8
    # jdk17_headless
    # jdk21_headless

    wl-clipboard
    wl-clip-persist
    kitty
    avizo
    quickemu # VM Launcher
    spice # VM Network
    qemu
    niv
  ];
}
