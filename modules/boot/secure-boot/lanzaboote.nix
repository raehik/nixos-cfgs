# To use Lanzaboote, you must already have systemd-boot. Check project repo.

{ lib, pkgs, ... }:

{

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  environment.systemPackages = [pkgs.sbctl]; # for troubleshooting Secure Boot

}
