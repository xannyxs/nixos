{ pkgs, ... }:

{
  users.users.xannyx = {
    isNormalUser = true;
    description = "a user";
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
      (writeShellScriptBin "obs" ''
        export GDK_BACKEND=x11
          ${obs-studio}/bin/obs "$@"
      '')
    ];
  };
}
