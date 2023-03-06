{ config, pkgs, lib, ... }:

let
  efiDevice  = "/dev/disk/by-partlabel/raehik-kfc-efi";
  rootDevice = "/dev/disk/by-partlabel/raehik-kfc-nixos";
in  {

  imports = [
    # set up filesystems: EFI (Secure Boot), 1 LUKS btrfs, subvols
    (import ./lib/fs-efi-sb-luks-btrfs-subvol.nix efiDevice rootDevice)
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      # "ja_JP.SJIS/SJIS" # 2022-12-14 raehik: not supported!
      "ja_JP.EUC-JP/EUC-JP"
      "C.UTF-8/UTF-8" # 2023-01-11 raehik: idk, apparently important
    ];
  };

  time.timeZone = "Europe/London";

  networking = {
    hostName = "kfc";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    pulseaudio # needed for pactl, which I use with PipeWire
  ];

}
