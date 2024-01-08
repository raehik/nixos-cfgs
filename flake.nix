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

    nixosSystem' = system: extraModules: inputs.nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        mod = m: ./modules/${m}.nix;
        home-manager = inputs.home-manager.nixosModules;
        nixos-hardware = inputs.nixos-hardware.nixosModules;
      };
      modules = [
        # general & flake-related bits
        ({ ... }: {
          # set revision (obtain via nixos-version --json)
          # null on dirty worktree!
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;

          # need this! home-manager fails without it :O
          # TODO check which ones it needs
          #nix.settings.experimental-features = ["nix-command" "flakes"];
        })

        # TODO
        #inputs.home-manager.nixosModules.home-manager {
        #  # TODO
        #  home-manager.useGlobalPkgs = true;
        #}
      ] ++ extraModules;
    };

  in {

    nixosConfigurations.kfc   = nixosSystem' "x86_64-linux" [
      sys/kfc.nix
      inputs.lanzaboote.nixosModules.lanzaboote
    ];
    nixosConfigurations.pichu = nixosSystem' "x86_64-linux" [
      modules/sys/pichu.nix
      inputs.lanzaboote.nixosModules.lanzaboote
    ];
    nixosConfigurations.reese = nixosSystem' "aarch64-linux" [
      sys/reese.nix
      inputs.nixos-hardware.nixosModules.raspberry-pi-4
    ];

  };

}
