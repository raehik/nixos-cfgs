# 2023-02-07 raehik: from https://nixos.wiki/wiki/Podman

# { pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.dnsname.enable = true;
    };
  };
}
