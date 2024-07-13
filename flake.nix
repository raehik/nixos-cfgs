{

  inputs = {
    # 2023-10-26: need master for fcitx5 package fix (breakpad)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs@{ self, nixpkgs, ... }:

  let

    lib = import ./lib inputs;

    nixosSystem' = extraModules: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        mod = m: ./modules/${m}.nix;
        home-manager = inputs.home-manager.nixosModules;
        nixos-hardware = inputs.nixos-hardware.nixosModules;
      };
      modules = [
        ({ ... }: {
          # set revision (obtain via nixos-version --json) -- null when dirty
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
        })
      ] ++ extraModules;
    };

  in {

    nixosConfigurations.kfc   = nixosSystem' [
      sys/kfc.nix
      inputs.lanzaboote.nixosModules.lanzaboote
    ];
    nixosConfigurations.pichu = nixosSystem' [
      modules/sys/pichu.nix
      inputs.lanzaboote.nixosModules.lanzaboote
    ];
    nixosConfigurations.reese = nixosSystem' [
      modules/sys/reese.nix
      inputs.nixos-hardware.nixosModules.raspberry-pi-4
    ];

  };

}
