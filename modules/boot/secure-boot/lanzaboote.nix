{ pkgs, ... }:

{

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  environment.systemPackages = with pkgs; [
    sbctl # for troubleshooting Secure Boot
  ];

}
