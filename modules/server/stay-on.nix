{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella = {
      stay-on = {
        enable = lib.mkEnableOption "Lässt das Gerät nicht ausgehen";
      };
    };
  };

  config = lib.mkIf config.xanterella.stay-on.enable {
    boot = {
      kernelParams = [
        "consoleblank=60"
      ];
    };
    services = {
      logind = {
        lidSwitch = "ignore";
        lidSwitchExternalPower = "ignore";
        lidSwitchDocked = "ignore";
      };
    };
    systemd = {
      targets = {
        sleep = {
          enable = false;
        };
        suspend = {
          enable = false;
        };
        hibernate = {
          enable = false;
        };
        hybrid-sleep = {
          enable = false;
        };
      };
    };
  };
}
