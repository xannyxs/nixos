{ ... }:
{
  swapDevices = [
    {
      device = "/swapfile";
      size = 32768; # 32GB = 32 * 1024 = 32768 MB
    }
  ];
}
