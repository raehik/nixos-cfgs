{ config, pkgs, ... }:

let
  mod = m: ./${m}.nix;
  modF = m: import (mod m);
  modNasCauldron = share: folder: modF "ops/nas/lazy"
    "//192.168.0.74/${share}" "/media/nas/cauldron/${folder}"
    "raehik" "users" "credentials=/secret/nas/cauldron/raehik";
in {

  networking.hostName = "pichu";
  system.stateVersion = "22.11";

  imports = [
    ./hw/sys/pichu.nix
    ./boot/sys/pichu.nix

    ./boot/kernel/zram-swap.nix

    ./ops/locale/raehik.nix
    ./ops/net.nix
    ./ops/shell.nix

    ./ops/user/raehik.nix

    ./ops/nix/cachix.nix
    ./ops/nix/substitutors/iog.nix

    ./sw/audio.nix
    ./sw/home-manager.nix
    ./sw/udisks2.nix
    ./sw/graphical.nix
    ./sw/podman.nix
    ./sw/bluetooth.nix

    ./sw/gaming.nix

    # home local network things
    ./sw/print/home.nix
    (modNasCauldron "raehik" "raehik")
    (modNasCauldron "Public" "shared")
  ];

}
