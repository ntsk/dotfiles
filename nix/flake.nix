{
  description = "Home Manager and nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-darwin, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      currentUser = builtins.getEnv "USER";
      mkHomeConfig = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      mkDarwinConfig = system:
        let
          username = currentUser;
        in nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit username; };
          modules = [
            ./darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.users.${username} = { pkgs, lib, ... }: {
                imports = [ ./home.nix ];
                home.username = lib.mkForce username;
                home.homeDirectory = lib.mkForce "/Users/${username}";
              };
            }
          ];
        };
    in {
      homeConfigurations = {
        "x86_64-linux" = mkHomeConfig "x86_64-linux";
        "aarch64-linux" = mkHomeConfig "aarch64-linux";
        "x86_64-darwin" = mkHomeConfig "x86_64-darwin";
        "aarch64-darwin" = mkHomeConfig "aarch64-darwin";
      };
      darwinConfigurations = {
        "aarch64-darwin" = mkDarwinConfig "aarch64-darwin";
        "x86_64-darwin" = mkDarwinConfig "x86_64-darwin";
      };
    };
}
