{ pkgs, ... }:

{

  imports = [ ../cpu/intel.nix ../gpu/intel.nix ../wifi.nix ];

  # required for iwlwifi driver (fails silently without!)
  hardware.enableRedistributableFirmware = true;

  # intel_pstate has powersave and performance, both scheduler-driven
  powerManagement.cpuFreqGovernor = "powersave";

  # bit arbitrary, unclear if thermald works on this Intel CPU (i5-10210U)
  services.thermald.enable = true;

  # bit arbitrary, idk which powertop does by default
  powerManagement.powertop.enable = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];

  # drivers etc. let's just get everything who cares
  boot.kernelPackages = pkgs.linuxPackages_latest;

}
