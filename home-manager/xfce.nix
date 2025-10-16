{ ... }:

{
  xfconf.settings = {
    xfce4-keyboard-shortcuts = {
      # Commands shortcuts
      "commands/custom/<Super>t" = "kitty";
      "commands/custom/<Super>e" = "thunar";
      "commands/custom/<Super>l" = "xflock4";
      "commands/custom/<Super>space" = "xfce4-appfinder";
      "commands/custom/<Super>q" = "xkill";

      # Window manager shortcuts
      "xfwm4/custom/<Super>Down" = "tile_down_key";
      "xfwm4/custom/<Super>Left" = "tile_left_key";
      "xfwm4/custom/<Super>Right" = "tile_right_key";
      "xfwm4/custom/<Super>Up" = "tile_up_key";
      "xfwm4/custom/<Shift><Super>Enter" = "full_screen";
    };

    xfwm4 = {
      "general/button_layout" = "O|C";
      "general/title_font" = "Berkeley Mono Ultra-Bold 11";
      "general/title_alignment" = "left";
    };
  };

  xfconf.settings = {
    xfce4-terminal-preferences = {
      "DropdownStatusIcon" = false;
      "MiscDefaultTerminal" = true;
    };

    xfce4-preferred-applications = {
      "TerminalEmulator/Name" = "Kitty";
      "TerminalEmulator/Command" = "kitty";
    };
  };
}
