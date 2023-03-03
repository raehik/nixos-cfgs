{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations.alex = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./etc-nixos/configuration.nix
        # "make home manager available to configuration.nix" (?)
        inputs.home-manager.nixosModules.home-manager {
          # have home-manager use system-level nixpkgs
          home-manager.useGlobalPkgs = true;
        }
      ];
    };
  };
}
