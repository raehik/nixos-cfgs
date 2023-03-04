# Looks like enabling powertop fixed the perma-loud fan.
# But I also did hardware.enableAllFirmware at the same time.

{ config, lib, pkgs, modulesPath, ... }:

{

  # need for iwlwifi
  hardware.enableRedistributableFirmware = true;

  hardware.cpu.intel.updateMicrocode = true;

  # 2023-03-04: fairly recent laptop, let's be bleeding edge
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # idk gimme it all
  hardware.enableAllFirmware = true;

  boot.initrd.luks.devices."cryptroot-raehik-kfc-nixos".device = "/dev/disk/by-uuid/6cf3e4d7-ea19-4d7b-a7e3-15a4f7bc3883";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8e23b053-d007-4990-9a8e-20fd6e171273";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/8e23b053-d007-4990-9a8e-20fd6e171273";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/8e23b053-d007-4990-9a8e-20fd6e171273";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=nix" "noatime" ];
    };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9ECC-4265";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  console.useXkbConfig = true;
  services.xserver.layout = "gb";

  # attempt to fix fan...
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.powertop.enable = true;

  # 2023-03-04: doesn't work! says it can't run on this CPU and fails gracefully
  services.thermald.enable = true;

  # I HATE NVIDIA GRAAAAAHHHH
  #boot.kernelParams = ["nomodeset"];
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = ["nvidia"];
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

}
