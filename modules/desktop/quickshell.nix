{
  config,
  pkgs,
  lib,
  pkgs-new,
  inputs,
  ...
}: {
  options = {
    xanterella = {
      quickshell = {
        enable = lib.mkEnableOption "Aktiviert quickshell";
      };
      quickshell_noctalia = {
        enable = lib.mkEnableOption "Aktiviert Quickshell mit der Noctalia Shell";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.quickshell.enable {
      environment = {
        systemPackages = with pkgs-new; [
          quickshell
        ];
      };
      environment = {
        variables = {
          QML_XHR_ALLOW_FILE_READ = "1";
        };
      };
    })
    (lib.mkIf config.xanterella.quickshell_noctalia.enable {
      environment = {
        systemPackages = [
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      };
    })
  ];
}
