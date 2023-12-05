{ config, pkgs, ... }:

let
  mod = m: ./${m}.nix;
  modF = m: import (mod m);
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

    ./sw/print/home.nix
    ./sw/gaming.nix

    (modF "ops/nas/lazy"
          "//192.168.0.74/raehik" "/media/nas/cauldron/raehik"
          "raehik" "users"
          "credentials=/secret/nas/cauldron/raehik")
  ];

}
