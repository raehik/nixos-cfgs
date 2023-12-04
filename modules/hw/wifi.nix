# Wifi using iwd (on NetworkManager).
{
  networking = {
    wireless.iwd.enable = true;
    networkmanager.wifi.backend = "iwd";
  };
}
