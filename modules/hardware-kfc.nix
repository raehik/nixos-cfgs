{ config, lib, pkgs, modulesPath, ... }:

{

  # keyboard layout
  console.useXkbConfig = true;
  services.xserver.layout = "gb";

  # power management
  # need powertop and maybe other things like new Linux, enableAllFirmware, or
  # fan is really loud all the time.
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.powertop.enable = true;
  services.thermald.enable = true; # 2023-03-04: fails gracefully (wrong CPU)

  # drivers etc.
  hardware.cpu.intel.updateMicrocode = true;
  # 2023-03-04: fairly recent laptop, let's be bleeding edge
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true; # need for iwlwifi
  hardware.enableAllFirmware = true; # idk gimme it all

  # looks like Lenovo supports fwupd with this laptop
  # ...I wasn't able to use it due to poor interaction with Secure Boot. I could
  # disable Secure Boot and use, but at that point I could just use Windows.
  # Lol. regardless, here it is.
  services.fwupd.enable = true;

  # video drivers
  # I HATE NVIDIA GRAAAAAHHHH
  #boot.kernelParams = ["nomodeset"]; # required for builtin/free drivers
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = ["nvidia"];
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl = {
    enable = true;
  };

  # generated!
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

}
