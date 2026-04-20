{
  config,
  pkgs,
  ...
}: {
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          FastConnectable = "true";
        };
      };
    };
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };
}
