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
      "docker"
      "disk"
      "usb"
      "kvm"
      "libvirtd"
    ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      # Check firejail.nix
      # spotify
      # librewolf
      # ungoogled-chromium
      telegram-desktop
      # google-chrome

      vscodium
      vlc
      tor-browser
      obs-studio
      steam
      (pkgs.writeShellScriptBin "obs" ''
        export GDK_BACKEND=x11
          ${pkgs.obs-studio}/bin/obs "$@"
      '')
      # mixxx
      mongodb-compass
      prismlauncher
      distrobox
      davinci-resolve-studio
    ];
  };

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        DRI_PRIME = "1";
      };
    };
  };

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
