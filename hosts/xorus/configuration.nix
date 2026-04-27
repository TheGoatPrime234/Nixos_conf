{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  security.pam.services.sddm.enableKwallet = true;
  networking.networkmanager.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland];

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    PASSWORD_STORE = "basic";
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11"; # Did you read the comment?
}
