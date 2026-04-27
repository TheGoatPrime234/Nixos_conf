{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.syncthing.enable = lib.mkEnableOption "Aktiviert syncthing";
  };

  config = lib.mkIf config.xanterella.syncthing.enable {
    environment.systemPackages = with pkgs; [
      syncthing
    ];
    services = {
      syncthing = {
        enable = true;
        user = "cato";
        dataDir = "/home/cato/Documents";
        configDir = "/home/cato/.config/syncthing";
        openDefaultPorts = true;
        overrideDevices = true;
        overrideFolders = true;
        settings = {
          devices = {
            "raspi" = {
              id = "IKHZFQ4-UEA4QFZ-AQETPT7-TH2J65Z-3UBP6Y5-KP4QEVI-YR6QNR5-43YSAAC";
            };
          };
          folder = {
            "Vaults" = {
              id = "ngxgj-f2ouz";
              path = "/home/cato/Documents/Vaults";
              devices = ["raspi"];
              versioning = {
                type = "staggered";
                params = {
                  cleanInterval = "3600";
                  maxAge = "1000000";
                };
              };
            };
          };
        };
      };
    };
  };
}
