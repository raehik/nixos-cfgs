# Needs more setup elsewhere too.

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

  boot.initrd.luks.devices."cryptroot".device = rootDevice;

  fileSystems."/"     = mkCompressedBtrfsSubvol "root" [];
  fileSystems."/home" = mkCompressedBtrfsSubvol "home" [];
  fileSystems."/nix"  = mkCompressedBtrfsSubvol "nix"  ["noatime"];

  boot.loader.efi.canTouchEfiVariables = true;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  environment.systemPackages = with pkgs; [
    sbctl # for troubleshooting Secure Boot
  ];

  fileSystems."/boot" = { device = efiDevice; fsType = "vfat"; };

  swapDevices = [ ];

}
