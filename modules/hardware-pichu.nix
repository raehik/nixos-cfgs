{ config, lib, pkgs, modulesPath, ... }:

{

  # keyboard layout
  console.useXkbConfig = true;
  services.xserver.layout = "gb";

  # power management
  # this was nice for kfc, so try some similar stuff
  powerManagement.cpuFreqGovernor = "powersave";
  services.thermald.enable = true; # TODO does this work for this hardware?
  powerManagement.powertop.enable = true; # TODO what does this do really

  # drivers etc. let's just get everything who cares
  hardware.cpu.intel.updateMicrocode = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  # video drivers
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  services.xserver.videoDrivers = ["intel"];

  # generated!
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

}
