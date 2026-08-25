{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      aircrack-ng = {
        enable = true;
      };
      wordlists = {
        enable = true;
      };
      hashcat = {
        enable = true;
      };
      git-dumper = {
        enable = true;
      };
      gobuster = {
        enable = true;
      };
      ffuf = {
        enable = true;
      };
      metasploit = {
        enable = true;
      };
      openvpn = {
        enable = true;
      };
      nmap = {
        enable = true;
      };
      hydra = {
        enable = true;
      };
      wifite = {
        enable = true;
      };
      wireshark = {
        enable = true;
      };
      proxychains = {
        enable = true;
      };
    };
  };
}
