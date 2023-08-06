{ config, lib, pkgs, modulesPath, ... }:

{

  # configure zram blocks for swap use
  # decent-seeming guide: https://unix.stackexchange.com/q/594817
  # apparently want ~(expected compression ratio)x RAM for max swap, but many
  # just say 1.5x
  # lz4: ~2.5x compression, fast
  # zstd: ~3x compression, slow
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 150;
  };

  # recommended settings from https://wiki.archlinux.org/title/Zram
  # we want high swappiness because our swap is on our RAM!
  # 150-200 seems recommended.
  # other settings idk but Fedora ppl discussed em.
  boot.kernel.sysctl = {
    "vm.swappiness" = 200;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

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
