{ config, pkgs, ... }:

let
  importModules = map (module: ../modules/${module}.nix);
in {

  networking.hostName = "reese";

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

  imports = importModules [
    "locale-raehik"
    "net"
    "user"
    #"cachix"
    #"substitutors/iog"
    #"audio"
    #"bluetooth"
    #"graphical"
    #"print/home"
    "assorted"
    #"home-manager"
    #"podman"
  ];

  system.stateVersion = "23.11";

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  #nix.extraOptions = {
  #  keep-derivations = true;
  #  keep-outputs = true;
  #};

  home-manager.users.raehik = { pkgs, ... }: {
    home.stateVersion = "23.11";

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    home.packages = with pkgs; [
      # basic
      openssl
      neovim
      tmux
      ripgrep
      git
      delta # for nicer git diff
      ## filesystems
      cifs-utils
      ntfs3g
      ## files
      atool
      unzip
      zip
      p7zip
      #unrar # TODO: unfree...?!
      ## admin
      htop

      # development
      gh # GitHub CLI tool (comes in handy)
    ];
  };

  services.udisks2.enable = true;

  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/nas/cauldron/raehik" = {
      device = "//cauldron.local/raehik";
      fsType = "cifs";
      options = let
        # this line prevents hanging on network split
        automount_opts =
          "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=10s,x-systemd.mount-timeout=10s";
        permission_opts = "uid=${toString config.users.users."raehik".uid},gid=${toString config.users.groups."users".gid}";

      in
      ["${automount_opts},credentials=/secret/samba/cauldron/raehik,${permission_opts}"];
  };

}
