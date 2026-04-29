{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      boot.enable = true;
      colmena.enable = true;
      git.enable = true;
      local.enable = true;
      nix.enable = true;
      nixvim.enable = true;
      ssh.enable = true;
    };
  };
}
