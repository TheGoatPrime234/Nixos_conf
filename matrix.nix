{ config, pkgs, ... }: 

{
  environmet.SystemPackages = with pkgs; [
    gomuks
  ];
}