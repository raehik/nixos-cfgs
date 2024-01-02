{ config, pkgs, ... }:

let
  mod = m: ../${m}.nix;
  modF = m: import (mod m);
  modNasCauldron = share: folder: modF "ops/nas/lazy"
    "//192.168.0.74/${share}" "/media/nas/cauldron/${folder}"
    "raehik" "users" "credentials=/secret/nas/cauldron/raehik";
in {

  networking.hostName = "pichu";
  system.stateVersion = "22.11";

  imports = [
    (mod "hw/sys/pichu")
    (mod "boot/sys/pichu")

    (mod "boot/kernel/zram-swap")

    (mod "ops/locale/raehik")
    (mod "ops/net")
    (mod "ops/shell")

    (mod "ops/user/raehik")

    (mod "ops/nix/cachix")
    (mod "ops/nix/substitutors/iog")

    (mod "sw/audio")
    (mod "sw/home-manager")
    (mod "sw/udisks2")
    (mod "sw/graphical")
    (mod "sw/podman")
    (mod "sw/bluetooth")

    (mod "sw/gaming")

    # home local network things
    (mod "sw/print/home")
    (modNasCauldron "raehik" "raehik")
    (modNasCauldron "Public" "shared")
  ];

}
