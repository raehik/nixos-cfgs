# System boot and filesystem configuration.

# Bootloader: EFI, unencrypted.
# System: 1 LUKS partition, btrfs, root/nix/home subvolumes, zstd compression.
# No swap (for now, idk how to do it properly).

let

  efiDevice = "/dev/disk/by-partlabel/raehik-1tb-nvme-alex-efi";
  rootDevice = "/dev/disk/by-partlabel/raehik-1tb-nvme-alex-nixos";
  luksDMName = "cryptroot";
  rootLV = "/dev/mapper/${luksDMName}"
  makeCompressedBtrfsSubvol = name: opts: {
    fsType = "btrfs";
    device = rootLV;
    options = [ "subvol=${name}" "compress=zstd" ] ++ opts;
  };

in {

  imports = [ ./alex/hardware-configuration.nix ];

  # bootloader (EFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # LUKS
  boot.initrd.luks.devices.${luksDMName}.device = rootDevice;

  fileSystems."/"     = makeCompressedBtrfsSubvol "root" [];
  fileSystems."/nix"  = makeCompressedBtrfsSubvol "nix"  ["noatime"];
  fileSystems."/home" = makeCompressedBtrfsSubvol "home" [];

  fileSystems."/boot" =
    { device = efiDevice;
      fsType = "vfat";
    };

  swapDevices = [ ];

}
