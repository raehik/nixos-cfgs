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
      #udisks
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

}
