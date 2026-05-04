{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      boot_server.enable = true;
      colmena.enable = true;
      git.enable = true;
      local.enable = true;
      network.enable = true;
      nix.enable = true;
      nixvim.enable = true;
      ssh.enable = true;
    };
  };
}
