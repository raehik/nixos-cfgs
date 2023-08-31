# Stuff that doesn't fit anywhere else.

{ pkgs, ... }:

{

  programs.nix-ld.enable = true;

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME    = "\${HOME}/.local/bin";
    XDG_DATA_HOME   = "\${HOME}/.local/share";

    # adds to PATH, doesn't replace
    PATH = [ "\${XDG_BIN_HOME}" ];
  };

}
