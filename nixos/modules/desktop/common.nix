# Shared by every desktop environment.
{ pkgs, ... }:

{
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    file-roller
    poweralertd
    playerctl
  ];
}
