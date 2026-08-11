{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = lib.mkForce [
    "pcie_brcmstb"
    "reset-raspberrypi"
    "sdhci_pci"
    "xhci_pci"
    "uas"
    "cqhci"
    "mmc_block"
    "usbhid"
    "usb_storage"
  ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = lib.mkForce ["vfat" "ext4" "ntfs3" "ntfs-3g"];

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.end0.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
