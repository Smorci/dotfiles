{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  description = "A flake for Smorci's personal NixOS configuration";

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.smorc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.marci = import ./users/marci/home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
