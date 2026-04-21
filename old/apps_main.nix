{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # System & Tools
    wget #
    pavucontrol # Ton in und outputs
    efibootmgr # Änderungen der EFIs
    gparted # Partionen
    btop
    sl # WICHTIG !!!

    ## Libs
    libnotify # Benachrichtigungen
    pciutils # Lib für PCI

    ## Files
    yazi # TUI Fileexplorer
    tree
    zip # Zipen
    unzip # Zipen
    syncthing # Dateisynchronisierung

    # Daily Use
    ## spotify --> spicetify
    obsidian
    vscode
    ani-cli

    # Hyprland Setup
    ## spicetify-cli --> spicetify
    rofi # Appmenu
    cava # Musikvisualisierung
    playerctl # Musikplayer integrationen

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
