stateVersion: user: { lib, home-manager, ... }:

{

  # TODO unsure about this
  nix.settings.experimental-features = ["nix-command"];

  imports = [
    home-manager.home-manager {
      home-manager.useGlobalPkgs = true;
    }
  ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  #nix.extraOptions = {
  #  keep-derivations = true;
  #  keep-outputs = true;
  #};

  home-manager.users.${user} = { pkgs, ... }: {
    home.stateVersion = stateVersion;
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
  };

}
