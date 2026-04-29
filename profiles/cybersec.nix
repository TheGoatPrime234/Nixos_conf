{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      aircrack-ng.enable = true;
      hashcat.enable = true;
      metasploit.enable = true;
      nmap.enable = true;
      wifite.enable = true;
    };
  };
}
