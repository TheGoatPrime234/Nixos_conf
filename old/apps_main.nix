{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # System & Tools
    wget #
    efibootmgr # Änderungen der EFIs
    gparted # Partionen
    btop
    sl # WICHTIG !!!

    ## Libs
    libnotify # Benachrichtigungen
    pciutils # Lib für PCI

    ## Files
    tree

    # Daily Use
    ## spotify --> spicetify
    vscode
    ani-cli

    # Hyprland Setup
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
