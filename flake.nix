{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap.url = "github:xremap/nix-flake";

    hyprland.url = "github:hyprwm/hyprland";

    stylix.url = "github:danth/stylix";

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (import ./packages)
      ];
    };
  in {
    nixosConfigurations.anomaly = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      modules = [
        ./hosts/default/configuration.nix
      ];
      specialArgs = {inherit system inputs;};
    };

    homeConfigurations = {
      nox = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.stylix.homeManagerModules.stylix
          inputs.nix-index-db.hmModules.nix-index
          ./hosts/default/home.nix
        ];
        extraSpecialArgs = {inherit inputs;};
      };
    };
  };
}
