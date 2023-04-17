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
      openssl
      neovim
      tmux
      ripgrep
      udisks
      cifs-utils
      ntfs3g
      atool
      unzip
      zip

      # development
      git
      delta # for nicer git diff
      gcc

      # graphical
      gammastep
      sway
      i3status-rust
      wl-clipboard
      mako
      slurp
      grim

      # terminal apps
      mpd
      ncmpcpp
      weechat

      # graphical apps
      foot
      pavucontrol
      firefox
      chromium
      hexchat
      sxiv
      zathura
      discord

      # laptop
      brightnessctl
    ];
  };

}
