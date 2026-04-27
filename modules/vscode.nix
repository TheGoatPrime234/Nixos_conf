{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    xanterella.vscode.enable = lib.mkEnableOption "Aktiviert vscode";
  };

  config = lib.mkIf config.xanterella.vscode.enable {
    environment.systemPackages = with pkgs; [
      vscode
    ];
  };
}
