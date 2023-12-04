{ pkgs, config, ... }:

{

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [epson-escpr cnijfilter2];

  # cnijfilter2 is unfree
  nixpkgs.config.allowUnfree = true;

}
