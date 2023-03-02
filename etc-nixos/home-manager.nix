{

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  #nix.extraOptions = {
  #  keep-derivations = true;
  #  keep-outputs = true;
  #};

  home-manager.users.raehik = { pkgs, ... }: {
    home.stateVersion = "22.11";

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    home.packages = with pkgs; [
      # basic
      neovim
      ripgrep
      udisks
      cifs-utils
      ntfs-3g
      atool

      # development
      git
      gcc

      # graphical
      wl-clipboard
      mako
      slurp
      grim
      hexchat

      # graphical apps
      sxiv
      zathura
      discord

      # laptop
      brightnessctl
    ];
  };

}
