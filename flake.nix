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
    colmena.url = "github:zhaofengli/colmena";
    p10k-src = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-programs,
    colmena,
    ...
  } @ inputs: let
    systemarch = "x86_64-linux";
    tarhost = "192.168.178.163";
    taruser = "root";
    pkgs-25-11 = import inputs.nixpkgs-25-11 {
      system = systemarch;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      xeravus = nixpkgs.lib.nixosSystem {
        system = systemarch;
        specialArgs = {inherit inputs pkgs-25-11;};
        modules = [
          ./hosts/xeravus/configuration.nix
        ];
      };
      xorus = nixpkgs.lib.nixosSystem {
        system = systemarch;
        specialArgs = {inherit inputs pkgs-25-11;};
        modules = [
          ./hosts/xorus/configuration.nix
        ];
      };
    };
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = systemarch;
          config.allowUnfree = true;
        };
        specialArgs = {inherit inputs pkgs-25-11;};
      };
      xeravus = {
        deployment = {
          targetHost = null;
          allowLocalDeployment = true;
          buildOnTarget = true;
        };
        imports = [
          ./hosts/xeravus/configuration.nix
        ];
      };
      xorus = {
        deployment = {
          targetHost = tarhost;
          targetUser = taruser;
          buildOnTarget = false;
        };
        imports = [
          ./hosts/xorus/configuration.nix
        ];
      };
    };
  };
}
