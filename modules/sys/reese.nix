{ mod, config, pkgs, system, ... }:

let
  modF = m: import (mod m);
  modNasCauldron = share: folder: modF "ops/nas/lazy"
    "//192.168.0.74/${share}" "/media/nas/cauldron/${folder}"
    "raehik" "users" "credentials=/secret/nas/cauldron/raehik";
  modPkgList = pkgList:
    modF "sw/home-manager/user-home-pkgs" "raehik" (modF "pkgs/${pkgList}");
in {

  nixpkgs.hostPlatform = "aarch64-linux";
  networking.hostName = "reese";
  system.stateVersion = "23.11";

  imports = [
    (mod "ops/locale/raehik")
    (mod "ops/net")
    (mod "ops/user/raehik")
    (mod "sw/udisks2")
    (modF "sw/home-manager" config.system.stateVersion "raehik")
    (modPkgList "base")
    (modPkgList "graphical")
    (modNasCauldron "raehik" "raehik")
    (modNasCauldron "Public" "shared")
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      #PasswordAuthentication = false;
      #KbdInteractiveAuthentication = false;
    };
  };

  # decent-seeming guide: https://unix.stackexchange.com/q/594817
  # apparently want ~(expected compression ratio)x RAM for max swap, but many
  # just say 1.5x
  # lz4: ~2.5x compression, fast
  # # zstd: ~3x compression, slow
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 150;
  };
  swapDevices = []; # required for zram swap idk why shit fucked

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

  # shit RAM with 4 cores -> bad time. don't go over 2 jobs.
  nix.settings.max-jobs = 2;

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  #nix.extraOptions = {
  #  keep-derivations = true;
  #  keep-outputs = true;
  #};

}
