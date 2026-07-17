{
  pkgs,
  st-src,
  dwm-src,
  dmenu-src,
  ...
}:

{
  # services.xserver.enable = true;
  # services.xserver.windowManager.dwm.enable = true;
  # programs.slock.enable = true;

  # systemd.user.services.statusbar = {
  #   description = "dwm status bar";
  #   wantedBy = [ "graphical-session.target" ];
  #   serviceConfig = {
  #     ExecStart = "/home/xannyx/.local/bin/statusbar.sh";
  #     Restart = "always";
  #   };
  # };

  environment.systemPackages = with pkgs; [
    # dmenu
    # slock
    st
  ];

  nixpkgs.overlays = [
    (self: super: {
      st = super.st.overrideAttrs (oldAttrs: {
        pname = "st-custom";
        version = "unstable";
        src = st-src;
        buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
      });

      # dwm = super.dwm.overrideAttrs (oldAttrs: {
      #   pname = "dwm-custom";
      #   version = "unstable";
      #   src = dwm-src;
      # });

      # dmenu = super.dmenu.overrideAttrs (oldAttrs: {
      #   pname = "dmenu-custom";
      #   version = "unstable";
      #   src = dmenu-src;
      # });
    })
  ];
}
