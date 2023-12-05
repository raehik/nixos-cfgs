# Note that mount won't resolve hostnames. You have to pass an IP addr. Sorry.

device: mountpoint: user: group: extraOpts: { config, ... }:

let
  uid = toString config.users.users."${user}".uid;
  gid = toString config.users.groups."${group}".gid;
  # TODO hopefully this is like lazy mounting...?
  automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=10s,x-systemd.mount-timeout=10s";
in {

  fileSystems."${mountpoint}" = {
      device = device;
      fsType = "cifs";
      options = ["vers=3.0,${automount_opts},uid=${uid},gid=${gid},${extraOpts}"];
  };

}
