{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xannyx = {
    isNormalUser = true;
    description = "Xannyx";
    extraGroups = [
      "networkmanager"
      "input"
      "wheel"
      "video"
      "audio"
      "tss"
      "disk"
      "usb"
      "kvm"
      "libvirtd"
    ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      spotify
      vscodium
      librewolf
      ungoogled-chromium
      steam
      vlc
      telegram-desktop
      tor-browser
      obs-studio
      # (pkgs.writeShellScriptBin "obs" ''
      # export GDK_BACKEND=x11
      #   ${pkgs.obs-studio}/bin/obs "$@"
      # '')
      mixxx
      mongodb-compass
      prismlauncher
    ];
  };

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
