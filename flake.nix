{

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
  let
    lib = import ./lib inputs;
    nixosSystem' = name: system: inputs.nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        # general & flake-related bits
        ({ ... }: {
          # need this! home-manager fails without it :O
          nix.settings.experimental-features = ["nix-command" "flakes"];
        })

        # Secure Boot via lanzaboote
        inputs.lanzaboote.nixosModules.lanzaboote

        # TODO
        inputs.home-manager.nixosModules.home-manager {
          # TODO
          home-manager.useGlobalPkgs = true;
        }

        # non-flake module
        ./sys/${name}.nix
      ];
    };
  in {
    nixosConfigurations.kfc = nixosSystem' "kfc" "x86_64-linux";
  };

}
