{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  noctaliaConfigFile = ./noctalia.toml;
  fakeConfigDir = pkgs.runCommand "noctalia-fake-config-dir" {} ''
    mkdir -p $out/noctalia
    cp ${noctaliaConfigFile} $out/noctalia/config.json
  '';
  noctaliaWrapped = pkgs.symlinkJoin {
    name = "noctalia-wrapped";
    paths = [inputs.noctalia.packages.${pkgs.system}.default];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/noctalia \
        --set XDG_CONFIG_HOME ${fakeConfigDir}
    '';
  };
in {
  options = {
    xanterella = {
      noctalia = {
        enable = lib.mkEnableOption "Aktiviert den deklarativen Noctalia-Wrapper";
      };
      noctalia_vimjoyer = {
        enable = lib.mkEnableOption "";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.noctalia.enable {
      environment = {
        systemPackages = [
          noctaliaWrapped
        ];
        etc = {
          "wallpaper" = {
            source = inputs.wallpaper;
          };
        };
      };
      systemd = {
        user = {
          services = {
            noctalia = {
              description = "Noctalia Service";
              wantedBy = [
                "graphical-session.target"
              ];
              partOf = [
                "graphical-session.target"
              ];
              after = [
                "graphical-session.target"
              ];
              serviceConfig = {
                ExecStart = "${noctaliaWrapped}/bin/noctalia";
                Restart = "on-failure";
                RestartSec = 3;
              };
            };
          };
        };
      };
    })
    (lib.mkIf config.xanterella.noctalia_vimjoyer.enable {
      #packages.noctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      #  settings =
      #    (builtins.fromTOML
      #      (builtins.readFile ./noctalia.toml)).settings;
      #};
    })
  ];
}
