{ pkgs, ... }:

{
  home.file.".local/share/icons/hicolor/16x16/apps/google-chrome.png".source =
    "${pkgs.google-chrome}/share/icons/hicolor/16x16/apps/google-chrome.png";
  home.file.".local/share/icons/hicolor/24x24/apps/google-chrome.png".source =
    "${pkgs.google-chrome}/share/icons/hicolor/24x24/apps/google-chrome.png";
  home.file.".local/share/icons/hicolor/32x32/apps/google-chrome.png".source =
    "${pkgs.google-chrome}/share/icons/hicolor/32x32/apps/google-chrome.png";
  home.file.".local/share/icons/hicolor/48x48/apps/google-chrome.png".source =
    "${pkgs.google-chrome}/share/icons/hicolor/48x48/apps/google-chrome.png";
  home.file.".local/share/icons/hicolor/64x64/apps/google-chrome.png".source =
    "${pkgs.google-chrome}/share/icons/hicolor/64x64/apps/google-chrome.png";
  home.file.".local/share/icons/hicolor/128x128/apps/google-chrome.png".source =
    "${pkgs.google-chrome}/share/icons/hicolor/128x128/apps/google-chrome.png";
  home.file.".local/share/icons/hicolor/256x256/apps/google-chrome.png".source =
    "${pkgs.google-chrome}/share/icons/hicolor/256x256/apps/google-chrome.png";

  # Librewolf icons
  home.file.".local/share/icons/hicolor/16x16/apps/librewolf.png".source =
    "${pkgs.librewolf}/share/icons/hicolor/16x16/apps/librewolf.png";
  home.file.".local/share/icons/hicolor/24x24/apps/librewolf.png".source =
    "${pkgs.librewolf}/share/icons/hicolor/24x24/apps/librewolf.png";
  home.file.".local/share/icons/hicolor/32x32/apps/librewolf.png".source =
    "${pkgs.librewolf}/share/icons/hicolor/32x32/apps/librewolf.png";
  home.file.".local/share/icons/hicolor/48x48/apps/librewolf.png".source =
    "${pkgs.librewolf}/share/icons/hicolor/48x48/apps/librewolf.png";
  home.file.".local/share/icons/hicolor/64x64/apps/librewolf.png".source =
    "${pkgs.librewolf}/share/icons/hicolor/64x64/apps/librewolf.png";
  home.file.".local/share/icons/hicolor/128x128/apps/librewolf.png".source =
    "${pkgs.librewolf}/share/icons/hicolor/128x128/apps/librewolf.png";
  home.file.".local/share/icons/hicolor/256x256/apps/librewolf.png".source =
    "${pkgs.librewolf}/share/icons/hicolor/256x256/apps/librewolf.png";

  # Telegram icons
  home.file.".local/share/icons/hicolor/16x16/apps/telegram-desktop.png".source =
    "${pkgs.tdesktop}/share/icons/hicolor/16x16/apps/telegram-desktop.png";
  home.file.".local/share/icons/hicolor/24x24/apps/telegram-desktop.png".source =
    "${pkgs.tdesktop}/share/icons/hicolor/24x24/apps/telegram-desktop.png";
  home.file.".local/share/icons/hicolor/32x32/apps/telegram-desktop.png".source =
    "${pkgs.tdesktop}/share/icons/hicolor/32x32/apps/telegram-desktop.png";
  home.file.".local/share/icons/hicolor/48x48/apps/telegram-desktop.png".source =
    "${pkgs.tdesktop}/share/icons/hicolor/48x48/apps/telegram-desktop.png";
  home.file.".local/share/icons/hicolor/64x64/apps/telegram-desktop.png".source =
    "${pkgs.tdesktop}/share/icons/hicolor/64x64/apps/telegram-desktop.png";
  home.file.".local/share/icons/hicolor/128x128/apps/telegram-desktop.png".source =
    "${pkgs.tdesktop}/share/icons/hicolor/128x128/apps/telegram-desktop.png";
  home.file.".local/share/icons/hicolor/256x256/apps/telegram-desktop.png".source =
    "${pkgs.tdesktop}/share/icons/hicolor/256x256/apps/telegram-desktop.png";
}
