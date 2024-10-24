{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ git fish wget curl zip unzip ];
}
