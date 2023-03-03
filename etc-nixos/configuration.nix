# NixOS configuration entry point.
# "Features" are placed in their own *.nix file where possible.
# If they don't fit anywhere, they're chucked in here.
# The hope is that modules may be picked up and massaged for entirely different
# configurations.

{ config, pkgs, ... }:

{

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;

  time.timeZone = "Europe/London";

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    # "ja_JP.SJIS/SJIS" # 2022-12-14 raehik: not supported!
    "ja_JP.EUC-JP/EUC-JP"
    "C.UTF-8/UTF-8" # 2023-01-11 raehik: idk, apparently important
  ];

  networking.hostName = "nixos-usbtmp22";
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    pulseaudio # needed for pactl, which I use with PipeWire
  ];

  services.udisks2.enable = true;

  imports =
    [ ./boot/alex.nix
      ./terminal.nix
      ./user.nix
      ./podman.nix
      ./audio.nix
      ./graphical.nix
      ./printing.nix
      ./gaming.nix
      # <home-manager/nixos> # flake handles differently
      ./home-manager.nix
      ./cachix.nix
      ./substitutors/iog.nix
    ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # TODO 2022-12-19 raehik: pretty sure this doesn't work
  programs.ssh.startAgent = true;

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME    = "\${HOME}/.local/bin";
    XDG_DATA_HOME   = "\${HOME}/.local/share";

    # adds to PATH, doesn't replace
    PATH = [ "\${XDG_BIN_HOME}" ];

    # steam needs to find Proton-GE
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

}
