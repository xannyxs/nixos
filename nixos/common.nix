{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
    displayManager.gdm.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.locate.enable = true;
  services.locate.localuser = null;
}
