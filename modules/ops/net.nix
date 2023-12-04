# Basic network config: resolved, NetworkManager, mDNS.

{

  services.resolved.enable = true;

  networking.networkmanager = {
    enable = true;
    connectionConfig = { "connection.mdns" = 2; };
  };

  services.avahi = { enable = true; nssmdns = true; };

}
