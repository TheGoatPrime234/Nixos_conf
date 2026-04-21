{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.upower.enable = lib.mkEnableOption "Aktiviert upower";
  };

  config = lib.mkIf config.xanterella.upower.enable {
    environment.systemPackages = with pkgs; [
      upower
    ];
    services = {
      upower = {
        enable = true;
        usePercentageForPolicy = true;
        percentageLow = 15;
        percentageCritical = 5;
        percentageAction = 3;
        ciritcalPowerAction = "PowerOff";
      };
    };
  };
}
