{ config, pkgs, ... }:

let
  themeColors = {
    background = "#1e1e2e";
    text = "#cdd6f4";
    accent = "#89b4fa";
    surface = "#313244";
  };
in
{
  environment.systemPackages = with pkgs; [
    libcanberra-gtk3
    xkill
    xclip

    slock
    xss-lock
  ];

  systemd.user.services.xss-lock = {
    description = "Lock X session using slock";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig.ExecStart = "${pkgs.xss-lock}/bin/xss-lock -- ${pkgs.slock}/bin/slock";
  };

  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      accelProfile = "adaptive";
      naturalScrolling = true;
      clickMethod = "clickfinger";
    };
  };

  environment.xfce.excludePackages = with pkgs; [
    xfce4-taskmanager
    xfce4-terminal
    parole
    xterm
  ];

  services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = true;
      xterm.enable = false;
    };

    displayManager.lightdm = {
      enable = true;
      greeters.gtk.enable = false;
      greeters.mini = {
        enable = true;
        user = "xannyx";
        extraConfig = ''
          [greeter]
          show-password-label = true
          show-input-cursor = true
          password-alignment = left
          [greeter-theme]
          background-color = "${themeColors.background}"
          text-color = "${themeColors.text}"
          border-color = "${themeColors.accent}"
          password-background-color = "${themeColors.surface}"
          background-image = ""
          error-color = "#f38ba8"
          window-color = "#181825"
          border-color = "#89b4fa"
          password-color = "#cdd6f4"
        '';
      };
    };
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-volman
    ];
  };

  services.displayManager.defaultSession = "xfce";
}
