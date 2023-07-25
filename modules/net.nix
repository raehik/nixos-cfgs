{ lib, ... }:

{

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.resolved = {
    enable = true;
  };

  networking.networkmanager.enable = true;

  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  networking.networkmanager.connectionConfig = {
    "connection.mdns" = 2;
  };

}
