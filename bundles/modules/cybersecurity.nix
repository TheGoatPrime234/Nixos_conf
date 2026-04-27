# bundle
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/nmap.nix
    ./../../modules/wifite.nix
    ./../../modules/metasploit.nix
    ./../../modules/aircrack-ng.nix
  ];

  config = {
    xanterella = {
      nmap.enable = true;
      wifite.enable = true;
      metasploit.enable = true;
      aircrack-ng.enable = true;
    };
  };
}
