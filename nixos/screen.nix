{ pkgs, ... }:

{
  services.geoclue2.enable = true;

  services.redshift = {
    enable = true;
    provider = "geoclue2";
    brightness = {
      day = "1";
      night = "1";
    };
    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  programs.light.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl # Brightness settings
    nwg-displays # GUI Display Layout
  ];
}
