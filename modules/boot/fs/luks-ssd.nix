# Open a LUKS device on an SSD (adds some flags for SSD performance).

device: name: { pkgs, ... }:

{

  imports = [../ssd.nix];

  boot.initrd.luks.devices."${name}" = {
    device = device;

    # SSD. Has minimal security implications:
    # https://wiki.archlinux.org/title/Dm-crypt/Specialties#Discard/TRIM_support_for_solid_state_drives_(SSD)
    allowDiscards = true;

    # SSD. no-{read,write}-workqueue for better performance.
    # https://wiki.archlinux.org/title/Dm-crypt/Specialties#Disable_workqueue_for_increased_solid_state_drive_(SSD)_performance
    bypassWorkqueues = true;
  };

}
