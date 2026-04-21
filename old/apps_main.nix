{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # System & Tools
    wget #
    gparted # Partionen
    btop
    sl # WICHTIG !!!

    ## Libs
    libnotify # Benachrichtigungen
    pciutils # Lib für PCI

    ## Files
    tree

    # Daily Use
    vscode
    ani-cli

    ## spicetify-cli --> spicetify

    # Cybersec
    aircrack-ng
    metasploit
    nmap
    wifite2

    # Gaming
    discord
    steam
    protonup
  ];
}
