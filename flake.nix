{
  description = "Meine NixOs Systeme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-25-11.url = "github:nixos/nixpkgs/nixos-25.11";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
	# Inputs
        inputs.spicetify-nix.nixosModules.default
	inputs.nixvim.nixosModules.default

	# Wichtig
        ./hardware-configuration.nix

	# Abspaltung  
        ./configuration.nix
	./nvidia.nix
	./fonts.nix
	./apps_main.nix
	./unstable-packages.nix
	./programs.nix
	./services.nix
	./hardware.nix
	./boot.nix

	# Add-Ons  
	./pixiesddm.nix
        ./spicetify.nix
	./zen-browser.nix
	./nixvim.nix
#	./zsh.nix
	./alejandra.nix
      ];
    };
  };
}
