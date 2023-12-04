# EFI boot. Mounts an EFI partition at the regular /boot.

device: { ... }:

{

  boot.loader.efi.canTouchEfiVariables = true;
  fileSystems."/boot" = { device = device; fsType = "vfat"; };

}
