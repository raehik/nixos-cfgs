{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    lib = import ./lib inputs;
    nixosSystem' = name: system: nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ({ ... }: {
          # need this! home-manager fails without it :O
          nix.settings.experimental-features = ["nix-command" "flakes"];
        })
        ./sys/${name}.nix
        # TODO
        inputs.home-manager.nixosModules.home-manager {
          # TODO
          home-manager.useGlobalPkgs = true;
        }
      ];
    };
  in {
    nixosConfigurations.kfc = nixosSystem' "kfc" "x86_64-linux";
  };

}
