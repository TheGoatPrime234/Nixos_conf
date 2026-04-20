{
  config,
  pkgs,
  inputs,
  ...
}: let
  pkgs-25-11 = inputs.nixpkgs-25-11.legacyPackages.${pkgs.system};
in {
  environment.systemPackages = with pkgs-25-11; [
    quickshell
    element-desktop
  ];
}
