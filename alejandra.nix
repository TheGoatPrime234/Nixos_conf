{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.alejandra.defaultPackage.${pkgs.system}
  ];
}
