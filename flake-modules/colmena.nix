{
  inputs,
  withSystem,
  ...
}: let
  systemarch = "x86_64-linux";
  taruser = "root";
  commonSSHKeys = {
    "id_ed25519" = {
      keyFile = "/home/cato/.ssh/id_ed25519";
      destDir = "/etc/ssh";
      user = "root";
      group = "root";
      permissions = "0600";
    };
    "github_key" = {
      keyFile = "/home/cato/.ssh/id_github";
      destDir = "/root/.ssh";
      user = "root";
      permissions = "0600";
    };
  };
in {
  flake = {
    colmena = withSystem systemarch (
      {
        pkgs-new,
        pkgs-unstable,
        ...
      }:
        import ./colmena-hosts.nix {
          inherit inputs systemarch taruser commonSSHKeys pkgs-new pkgs-unstable;
        }
    );
  };
}
