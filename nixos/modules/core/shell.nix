{ pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  programs.neovim = {
    defaultEditor = true;
    enable = true;
  };

  environment.variables = {
    SUDO_EDITOR = "nvim";
    SYSTEMD_EDITOR = "nvim";
    EDITOR = "nvim";
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    zip
    unzip
    parted
    niv

    lsof
    iftop
    nmap
    tcpdump

    python3
  ];
}
