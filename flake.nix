{
  description = "Meine NixOs Systeme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-25-11.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-programs.url = "github:TheGoatPrime234/Nixos_programs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    p10k-src = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-programs,
    ...
  } @ inputs: {
    nixosConfigurations = {
      xeravus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/xeravus/configuration.nix
        ];
      };
      xorus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/xorux/configuration.nix
        ];
      };
    };
  };
}
