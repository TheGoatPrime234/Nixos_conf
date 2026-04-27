# bundle
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./../../modules/wifite.nix
  ];

  config = {
    xanterella = {
      nmap.enable = true;
    };
  };
}
