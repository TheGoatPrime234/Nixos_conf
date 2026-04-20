{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # System & Tools
    #neovim --> Nixvim
    wget #
    fastfetch # Fastfetch halt
    git # Versionierung
    tailscale # VPN
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
    ## sddm --> pixiesddm
    ## spicetify-cli --> spicetify
    hyprland # Tiling Manager
    hyprpaper # Hintergrund Bild
    hyprlock # Lockmanager
    hyprpicker # Colorpicker
    wlogout # Herunterfahrmenu
    waybar # Taskleiste
    pulsemixer # Lautstärkekontrolle (Win + G Alternative)
    grim #
    slurp #
    wl-clipboard #
    swaynotificationcenter # Benachrichtigunge
    kitty # Terminal
    zsh # Terminal engine
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
