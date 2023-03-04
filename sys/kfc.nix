{ config, pkgs, ... }:

let
  importModules = map (module: ../modules/${module}.nix);
in {

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  imports = importModules [
    "hardware-kfc"
    "host-kfc"
    "user"
    "podman"
    "audio"
    "graphical"
    "printing"
    "gaming"
    # <home-manager/nixos> # flake handles differently
    "home-manager"
    "cachix"
    "substitutors/iog"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

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
