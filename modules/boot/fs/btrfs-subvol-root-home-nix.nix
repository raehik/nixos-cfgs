# Configure 3 subvolumes on a BTRFS device: /, /home and /nix.

device: sharedOpts: { pkgs, ... }: let

  mkBtrfsSubvol = name: opts: {
    fsType = "btrfs";
    device = device;
    options = [ "subvol=${name}" ] ++ sharedOpts ++ opts;
  };

in {

  fileSystems."/"     = mkBtrfsSubvol "root" [];
  fileSystems."/home" = mkBtrfsSubvol "home" [];
  fileSystems."/nix"  = mkBtrfsSubvol "nix"  ["noatime"];

}
