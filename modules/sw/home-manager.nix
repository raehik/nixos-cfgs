stateVersion: user: { home-manager, lib, ... }:

{

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
    home.stateVersion = "${stateVersion}";
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
  };

}
