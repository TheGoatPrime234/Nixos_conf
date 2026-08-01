{
  description = "Meine NixOs Systeme";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
      flake = true;
    };
    nixpkgs-new = {
      url = "github:nixos/nixpkgs/nixos-26.05";
      flake = true;
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
      flake = true;
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      flake = true;
    };
    nix-programs = {
      url = "github:Xeravus/Nixos_programs/stable";
      flake = true;
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      flake = true;
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      flake = true;
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      flake = true;
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      flake = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      flake = true;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      flake = true;
    };
    colmena = {
      url = "github:zhaofengli/colmena";
      flake = true;
    };
    p10k-src = {
      url = "github:romkatv/powerlevel10k";
      flake = false;
    };
    pomo-src = {
      url = "github:Bahaaio/pomo";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    nix-programs,
    colmena,
    pomo-src,
    ...
  } @ inputs: let
    systemarch = "x86_64-linux";
    pkgs-new = import inputs.nixpkgs-new {
      system = systemarch;
      config = {
        allowUnfree = true;
      };
    };
    pkgs-unstable = import inputs.nixpkgs-unstable {
      system = systemarch;
      config = {
        allowUnfree = true;
      };
    };
    taruser = "root";
    commonSSHKeys = {
      "id_ed25519" = {
        keyFile = "/home/cato/.ssh/id_ed25519";
        destDir = "/etc/ssh";
        user = "root";
        group = "root";
        permissions = "0600";
      };
      "github_key" = {
        keyFile = "/home/cato/.ssh/id_github";
        destDir = "/root/.ssh";
        user = "root";
        permissions = "0600";
      };
    };
  in {
    nixosConfigurations = {
      xeravus = nixpkgs.lib.nixosSystem {
        system = systemarch;
        specialArgs = {inherit inputs pkgs-new pkgs-unstable;};
        modules = [
          inputs.disko.nixosModules.disko
          ./hosts/xeravus/configuration.nix
        ];
      };
      installer = nixpkgs.lib.nixosSystem {
        system = systemarch;
        specialArgs = {inherit inputs pkgs-unstable;};
        modules = [
          ./hosts/installer/configuration.nix
          ./profiles/ssh-keys.nix
        ];
      };
      vicuna-image = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs pkgs-new pkgs-unstable;};
        modules = [
          ./hosts/vicuna/configuration.nix
          ./profiles/ssh-keys.nix
          inputs.nixos-hardware.nixosModules.raspberry-pi-5
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
        ];
      };
      crylia = nixpkgs.lib.nixosSystem {
        system = systemarch;
        specialArgs = {inherit inputs pkgs-new pkgs-unstable;};
        modules = [
          ./hosts/crylia/configuration.nix
          ./profiles/ssh-keys.nix
        ];
      };
    };
    colmena = import ./colmena-hosts.nix {
      inherit inputs systemarch taruser commonSSHKeys pkgs-new pkgs-unstable;
    };
  };
}
