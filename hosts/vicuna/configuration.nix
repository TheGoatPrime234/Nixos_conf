{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../profiles/boot/boot-vicuna.nix
  ];
  networking = {
    hostName = "vicuna";
  };
  xanterella = {
    boot = {
      enable = lib.mkForce false;
    };
  };
  sdImage = {
    firmwareSize = 1024;
    populateFirmwareCommands = lib.mkForce ''
      # Pfad zum fertig kompilierten NixOS-System
      systemdir=${config.system.build.toplevel}

      # Originale Raspberry Pi Firmware kopieren
      cp -r ${pkgs.raspberrypifw}/share/raspberrypi/boot/* firmware/

      # WICHTIG: Den Ordner wieder beschreibbar machen!
      chmod -R +w firmware/

      # Den echten NixOS-Kernel und die RAM-Disk umbenennen und kopieren
      cp $systemdir/kernel firmware/kernel_2712.img
      cp $systemdir/initrd firmware/initrd

      # Die config.txt exakt auf den Pi 5 zuschneiden
      cat <<EOF > firmware/config.txt
      [pi5]
      kernel=kernel_2712.img
      initramfs initrd followkernel
      arm_64bit=1
      EOF

      # Dem Kernel sagen, wo das NixOS-Dateisystem liegt
      cat <<EOF > firmware/cmdline.txt
      console=tty0 root=/dev/disk/by-label/NIXOS_SD rootfstype=ext4 rootwait init=$systemdir/init
      EOF
    '';
  };
  hardware = {
    #bluetooth = { enable = false; };
    enableRedistributableFirmware = true;
  };
  system = {
    stateVersion = "26.05";
  };
}
