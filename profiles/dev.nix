{
  config,
  lib,
  ...
}: {
  config = {
    xanterella = {
      direnv = {
        enable = true;
      };
      lazysql = {
        enable = true;
      };
      nix-review = {
        enable = true;
      };
      nodejs = {
        enable = true;
      };
      vimgolf = {
        enable = true;
      };
      tokei = {
        enable = true;
      };
      vscode = {
        enable = true;
      };
      github-runner = {
        enable = true;
      };
      vaultwarden = {
        enable = true;
      };
    };
  };
}
