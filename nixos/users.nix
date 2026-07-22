{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xannyx = {
    isNormalUser = true;
    description = "Xannyx";
    extraGroups = [
      "networkmanager"
      "input"
      "wheel"
      "video"
      "audio"
      "tss"
      "docker"
      "disk"
      "usb"
      "kvm"
      "libvirtd"
    ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      prismlauncher
      (pkgs.writeShellScriptBin "obs" ''
        export GDK_BACKEND=x11
          ${pkgs.obs-studio}/bin/obs "$@"
      '')
    ];
  };

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        GAMEMODERUN = "1";
        AMD_VULKAN_ICD = "RADV";
        VKD3D_CONFIG = "dxr,dxr11";
        PROTON_ADD_CONFIG = "fsr4rdna3";
        PROTON_LOCAL_SHADER_CACHE = "1";
        MESA_SHADER_CACHE_MAX_SIZE = "16G";
        MESA_GLSL_CACHE_MAX_SIZE = "16G";
        WINE_VK_VULKAN_ONLY = "1";
        WINEDLLOVERRIDES = "dinput8,dxgi,dsound=n,b";
        DRI_PRIME = "1";
      };
      extraArgs = "-no-cef-sandbox -cef-disable-gpu";
    };
  };
}
