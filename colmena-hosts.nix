{
  inputs,
  systemarch,
  taruser,
  commonSSHKeys,
  pkgs-new,
  pkgs-unstable,
  ...
}: {
  meta = {
    nixpkgs = import inputs.nixpkgs {
      system = systemarch;
      config = {
        allowUnfree = true;
      };
      purity = "impure";
    };
    nodeNixpkgs = {
      vicuna = import inputs.nixpkgs {
        system = "aarch64-linux";
        config = {
          allowUnfree = true;
        };
      };
    };
    specialArgs = {inherit inputs pkgs-new pkgs-unstable;};
  };
  xeravus = {
    deployment = {
      targetHost = null;
      allowLocalDeployment = true;
      buildOnTarget = true;
    };
    imports = [
      ./hosts/xeravus/configuration.nix
      ./profiles/ssh-keys.nix
    ];
  };
  lacrux = {
    deployment = {
      targetHost = "192.168.178.34";
      targetUser = taruser;
      buildOnTarget = false;
      keys = commonSSHKeys;
    };
    imports = [
      ./hosts/xorus/configuration.nix
      ./profiles/ssh-keys.nix
    ];
  };
  megatron = {
    deployment = {
      targetHost = "crylia";
      targetUser = taruser;
      buildOnTarget = false;
      keys = commonSSHKeys;
    };
    imports = [
      ./profiles/ssh-keys.nix
      ./hosts/xorus/configuration.nix
    ];
  };
  vicuna = {
    deployment = {
      targetHost = "192.168.178.30";
      targetUser = taruser;
      buildOnTarget = false;
      keys = commonSSHKeys;
    };
    imports = [
      ./hosts/vicuna/configuration.nix
      ./profiles/ssh-keys.nix
      inputs.nixos-hardware.nixosModules.raspberry-pi-5
    ];
  };
}
