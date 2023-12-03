# raehik's NixOS system configurations
I don't know much about Nix yet. This is my initial barebones system
configuration wrapped into a flake. home-manager exists, but isn't used very
much.

## Deleting old generations
```
sudo nix-collect-garbage -d
sudo nixos-rebuild boot --flake .
```

`nixos-rebuild` figure out `/boot`. It's stupid and annoying, sorry.

## Initalizing a new system
Once your drive is prepped and mounted:

`sudo nixos-install --flake .#<system> --root <root mount>`

Note that Nix is smart enough to use its local store! (That blew my mind a bit.)

Remember to fiddle with Lanzaboote if you're using it. Go systemd-boot first,
then swap to Lanzaboote module.

`cryptsetup status <mapper name>` helps assert some config.

### Drive
For NVMe SSDs, consider setting the LBA format to 4096 bytes. This should give
better performance.

Check with `sudo nvme id-ns -H <NVMe device>`. Look for "LBA Format".

Note that as of 2023-12-03, nvme-cli won't work with a drive plugged in via a
USB enclosure. M.2 slot it and run Linux via another drive.

On 2023-12-03, raehik had a drive that reported it could handle 4k LBA size
(though both it and 512-byte were stated "best"), but he got a 0x2001 invalid
opcode error on trying. Seems that lots of drives are just shit.

### Device
512 MB EFI partition, rest for LUKS.

`mkfs.fat -F 32 <device>`

### Filesystem
Currently suggesting BTRFS.

#### BTRFS
On 2023-12-03, when raehik BTRFS formatted an NVMe SSD via an USB enclosure, it
showed no for "SSD Detected" after formatting. Some defaults used to change for
SSDs. From what I could see, no more, so maybe it's a some vestigial field,
written but not read. Unsure.

```
mkfs.btrfs <device>
mount <device> /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/home
umount /mnt
mount -o compress=zstd,subvol=root <device> /mnt
sudo mkdir /mnt/{nix,home}
mount -o compress=zstd,subvol=nix,noatime <device> /mnt/nix
mount -o compress=zstd,subvol=home <device> /mnt/home
# ...
```

No relevant options for filesystem or subvolume creation. (All happens on
mount.)
