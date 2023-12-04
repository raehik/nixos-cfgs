# To use Lanzaboote, you must already have systemd-boot. Check project repo.

{ pkgs, ... }:

{
  boot.lanzaboote = { enable = true; pkiBundle = "/etc/secureboot"; };
  environment.systemPackages = [pkgs.sbctl]; # for troubleshooting Secure Boot
}
