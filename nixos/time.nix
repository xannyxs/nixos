{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Paris";
  services.timesyncd.enable = true;
}
