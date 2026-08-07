{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.xanterella.noctalia;
  noctaliaConfigFile = ./noctalia.toml;
  fakeConfigDir = pkgs.runCommand "noctalia-fake-config-dir" {} ''
    mkdir -p $out/noctalia
    # Kopiere die JSON-Datei direkt in den Fake-Ordner
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
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [
        noctaliaWrapped
      ];
    };
  };
}
