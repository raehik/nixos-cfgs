{

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
  nix.settings.extra-experimental-features = "flakes nix-command";

}
