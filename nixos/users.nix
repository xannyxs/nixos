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
    shell = pkgs.fish;

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
      mixxx
      mongodb-compass
    ];
  };

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
