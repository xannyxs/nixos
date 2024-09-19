{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xannyx = {
    isNormalUser = true;
    description = "Xannyx";
    extraGroups = [ "networkmanager" "input" "wheel" "video" "audio" "tss" "disk" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      spotify
      vscodium
      librewolf
      ungoogled-chromium
      steam
      tor-browser
      obs-studio
      davinci-resolve-studio
      mixxx
      mongodb-compass

      # Javascript
      nodejs_20
      yarn
    ];
  };

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
