{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin }: {

  darwinConfigurations."ADMEs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
    modules = [
      home-manager.darwinModules.home-manager
      ./darwin-common.nix
      ./hosts/adme/default.nix 
    ]; # will be important later
  };
  
  darwinConfigurations."a-shtarev-mmac" = nix-darwin.lib.darwinSystem {
    system = "aarch64-darwin"; # "x86_64-darwin" if you're using a pre M1 mac
    modules = [
      home-manager.darwinModules.home-manager
      ./darwin-common.nix
      ./hosts/mmac/default.nix 
    ]; # will be important later
  };
  };

}
