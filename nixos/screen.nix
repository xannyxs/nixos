{ pkgs, ... }:

{
  services.geoclue2.appConfig = {
      "gammastep" = {
        isAllowed = true;
        isSystem = false;
        users = [ "1000" ];
      };
  };
  
  programs.light.enable = true;

  environment.systemPackages = with pkgs; [
    gammastep # Screen filter
    brightnessctl # Brightness settings

    nwg-displays # GUI Display Layout
  ];
}
