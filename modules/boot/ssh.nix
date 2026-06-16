{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      ssh = {
        enable = lib.mkEnableOption "Aktiviert ssh";
      };
      ssh-installer = {
        enable = lib.mkEnableOption "Aktiviert ssh für den Installer";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.ssh.enable {
      environment = {
        systemPackages = with pkgs; [
          openssh
          kitty.terminfo
        ];
      };
      programs = {
        ssh = {
          startAgent = true;
          askPassword = lib.mkForce "";
        };
      };
      services = {
        openssh = {
          enable = true;
          startWhenNeeded = true;
          settings = {
            UseDns = true;
            PermitRootLogin = "prohibit-password";
          };
          authorizedKeysFiles = lib.mkForce [
            "/etc/ssh/authorized_keys.d/%u"
            ".ssh/authorized_keys"
          ];
        };
      };
    })

    (lib.mkIf config.xanterella.ssh-installer.enable {
      programs = {
        ssh = {
          askPassword = lib.mkForce "";
        };
      };
      services = {
        openssh = {
          enable = true;
          settings = {
            PermitRootLogin = "yes";
          };
        };
      };
    })
  ];
}
