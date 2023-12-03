efiDevice: rootDevice: { pkgs, ... }: let

  luksName = "cryptroot";
  luksDevice = "/dev/mapper/${luksName}";
  mkCompressedBtrfsSubvol = name: opts: {
    fsType = "btrfs";
    device = luksDevice;
    options = [ "subvol=${name}" "compress=zstd" ] ++ opts;
  };

in

{

  boot.initrd.luks.devices."cryptroot" = {
    device = rootDevice;

    # SSD. Has minimal security implications:
    # https://wiki.archlinux.org/title/Dm-crypt/Specialties#Discard/TRIM_support_for_solid_state_drives_(SSD)
    allowDiscards = true;

    # SSD. no-{read,write}-workqueue for better performance.
    # https://wiki.archlinux.org/title/Dm-crypt/Specialties#Disable_workqueue_for_increased_solid_state_drive_(SSD)_performance
    bypassWorkqueues = true;
  };

  fileSystems."/"     = mkCompressedBtrfsSubvol "root" [];
  fileSystems."/home" = mkCompressedBtrfsSubvol "home" [];
  fileSystems."/nix"  = mkCompressedBtrfsSubvol "nix"  ["noatime"];

  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/boot" = { device = efiDevice; fsType = "vfat"; };

  swapDevices = [ ];

}
