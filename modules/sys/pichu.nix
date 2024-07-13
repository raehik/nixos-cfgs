{ mod, config, pkgs, lib, ... }:

let
  modF = m: import (mod m);
  modNasCauldron = share: folder: modF "ops/nas/lazy"
    "//192.168.0.74/${share}" "/media/nas/cauldron/${folder}"
    "raehik" "users" "credentials=/secret/nas/cauldron/raehik";
  modPkgList = pkgList:
    modF "sw/home-manager/user-home-pkgs" "raehik" (modF "pkgs/${pkgList}");
in {

  nixpkgs.hostPlatform = "x86_64-linux";
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

    (mod "hw/bluetooth")
    (mod "sw/audio")
    (modF "sw/home-manager" config.system.stateVersion "raehik")
    (modPkgList "base")
    (modPkgList "graphical")
    (mod "sw/udisks2")
    (mod "sw/graphical")
    (mod "sw/podman")

    (mod "sw/gaming")

    # home local network things
    (mod "sw/print/home")
    (modNasCauldron "raehik" "raehik")
    (modNasCauldron "Public" "shared")
  ];

}
