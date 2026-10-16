{ pkgs, ... }:

{
  programs.java.enable = true;

  environment.systemPackages = with pkgs; [
    # jdk8
    # jdk17_headless
    jdk21_headless
  ];
}
