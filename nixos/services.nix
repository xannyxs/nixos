{ pkgs, ... }:

{

  services.usbmuxd.enable = true; # tmp

  # Enable Services
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
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  environment.systemPackages = with pkgs; [
    hunspell
    hunspellDicts.nl_nl
    hunspellDicts.en_GB-ize

    home-manager
    file-roller

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
