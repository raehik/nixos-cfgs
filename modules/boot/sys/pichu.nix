let
  mod = m: ./../${m}.nix;
  modF = m: import (mod m);
in {
  imports = [
    (modF "fs/luks-ssd" "/dev/disk/by-partlabel/raehik-pichu2-nixos" "cryptroot")
    (modF "fs/btrfs-subvol-root-home-nix" "/dev/mapper/cryptroot" ["compress=zstd"])
    (modF "loader/efi" "/dev/disk/by-partlabel/raehik-pichu2-efi")
    (mod "loader/systemd-boot") # required before Lanzaboote
    #./fs/boot/secure-boot/lanzaboote.nix
  ];
}
