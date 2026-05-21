{
  description = "Home Manager and nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Android CLI is distributed as a single prebuilt binary per platform.
    # Tracking the "latest" URLs as flake inputs lets `nix flake update`
    # refresh them alongside everything else. No aarch64-linux binary exists.
    android-cli-aarch64-darwin = {
      url = "file+https://dl.google.com/android/cli/latest/darwin_arm64/android";
      flake = false;
    };
    android-cli-x86_64-darwin = {
      url = "file+https://dl.google.com/android/cli/latest/darwin_x86_64/android";
      flake = false;
    };
    android-cli-x86_64-linux = {
      url = "file+https://dl.google.com/android/cli/latest/linux_x86_64/android";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nix-darwin, ... }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      currentUser = builtins.getEnv "USER";
      androidCliFor = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          src = inputs."android-cli-${system}" or null;
        in if src == null
           then null
           else pkgs.callPackage ./pkgs/android-cli.nix { inherit src; };
      mkHomeConfig = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { androidCli = androidCliFor system; };
          modules = [ ./home/home.nix ];
        };
      mkDarwinConfig = system: username:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit username; };
          modules = [
            ./darwin/darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.extraSpecialArgs = { androidCli = androidCliFor system; };
              home-manager.users.${username} = { pkgs, lib, ... }: {
                imports = [ ./home/home.nix ];
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
        "aarch64-darwin" = mkDarwinConfig "aarch64-darwin" currentUser;
        "x86_64-darwin" = mkDarwinConfig "x86_64-darwin" currentUser;
      };
    };
}
