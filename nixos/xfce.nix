{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xorg.xkill
    xclip
  ];

  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      accelProfile = "adaptive";
      naturalScrolling = true;
      clickMethod = "clickfinger";
    };
  };

  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [
      # xfce.xfce4-about
      xfce.xfce4-taskmanager
      xfce.xfce4-terminal
      xfce.mousepad
      xterm
    ];
    desktopManager.xfce.enable = true;

    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        /*
          theme = {
            name = "Chicago95";
            package = chicago95.chicago95;
          };
          iconTheme = {
            name = "Chicago95";
            package = chicago95.chicago95;
          };
        */
      };
    };
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-volman
    ];
  };

  services.displayManager.defaultSession = "xfce";

}
