{ pkgs, ... }:

let
  xsct-auto = pkgs.writeShellScript "xsct-auto" ''
    hour=$(date +%H)
    if [ "$hour" -ge 6 ] && [ "$hour" -lt 20 ]; then
      ${pkgs.xsct}/bin/xsct 0
    else
      ${pkgs.xsct}/bin/xsct 4000 
    fi
  '';
in
{
  services.autorandr.enable = true;

  systemd.user.services.xsct-auto = {
    description = "Set screen color temperature based on time of day";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${xsct-auto}";
    };
  };

  systemd.user.timers.xsct-auto = {
    description = "Hourly screen color temperature update";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
  };

  environment.systemPackages = with pkgs; [
    xsct
    brightnessctl
    nwg-displays
    arandr
    autorandr
  ];
}
