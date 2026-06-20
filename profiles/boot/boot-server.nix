{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      boot-server = {
        enable = true;
      };
      stay-on = {
        enable = true;
      };
      colmena = {
        enable = true;
      };
      git = {
        enable = true;
      };
      local = {
        enable = true;
      };
      network = {
        enable = true;
      };
      nix = {
        enable = true;
      };
      nixvim = {
        enable = true;
      };
      tailscale = {
        enable = true;
      };
      ssh = {
        enable = true;
      };
    };
  };
}
