{ config, pkgs, ... }:

{
  time.timeZone = "Asia/Bangkok";
  services.timesyncd.enable = true;
}
