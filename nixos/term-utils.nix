{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    zip
    unzip

    python3
    python313Packages.selenium
  ];
}
