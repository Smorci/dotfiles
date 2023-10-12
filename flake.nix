{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
  };

  description = "A flake for Smorci's personal NixOS configuration";

  outputs = inputs@{ self, nixpkgs, home-manager, agenix, ... }: {
   
    nixosConfigurations.smorci = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./system/configuration.nix
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.smorci = import ./users/smorci/home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
