{
  config,
  lib,
  ...
}: {
  options = {
    xanterella = {
      element = {
        enable = lib.mkEnableOption "Aktiviert Element(Matrix Messanger";
      };
    };
  };
  config = lib.mkIf config.xanterella.element.enable {
    environment = {
      systemPackages = with pkgs; [
        element
      ];
    };
  };
}
