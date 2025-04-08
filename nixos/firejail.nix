{ pkgs, lib, ... }:

{
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      /*
        librewolf = {
          executable = "${lib.getBin pkgs.librewolf}/bin/librewolf";
          profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
          desktop = "${pkgs.librewolf}/share/applications/librewolf.desktop";
        };
      */

      google-chrome-stable = {
        executable = "${pkgs.google-chrome}/bin/google-chrome-stable";
        profile = "${pkgs.firejail}/etc/firejail/google-chrome.profile";
        desktop = "${pkgs.google-chrome}/share/applications/google-chrome.desktop";
      };

      # spotify = {
      #   executable = "${lib.getBin pkgs.spotify}/bin/spotify";
      #   profile = "${pkgs.firejail}/etc/firejail/spotify.profile";
      #   # desktop = "${pkgs.spotify}/share/applications/spotify.desktop";
      # };
      #
      # telegram-desktop = {
      #   executable = "${lib.getBin pkgs.telegram-desktop}/bin/telegram-desktop"; # or tdesktop
      #   profile = "${pkgs.firejail}/etc/firejail/telegram.profile";
      #   desktop = "${pkgs.telegram-desktop}/share/applications/org.telegram.desktop.desktop"; # or tdesktop
      # };

      /*
        ungoogled-chromium = {
          executable = "${lib.getBin pkgs.ungoogled-chromium}/bin/chromium"; # changed binary name
          profile = "${pkgs.firejail}/etc/firejail/chromium-browser.profile";
          desktop = "${pkgs.ungoogled-chromium}/share/applications/chromium-browser.desktop";
        };
      */
    };
  };
}
