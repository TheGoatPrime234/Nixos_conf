{
  config,
  pkgs,
  ...
}: {
  opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
