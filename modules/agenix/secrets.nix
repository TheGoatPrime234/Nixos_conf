let
  cato = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHc0eOrLgxwDdvrFC9WEtOsh+Sx5AqZUUKxhrQWaPIPE cato.jenisch@gmail.com";
  users = [
    cato
  ];

  xeravus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzkvv1qjg8y//HRhcyEoZ7luoVhBNgqvJ1HIzceAVu1";
  lutik = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFxZS/IOSqNcBYlg1oCDUIzqURCiNoQTmdXXQKcSfMpY";
  xorus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILRuBimJgERluZGC7Jo1cd/DODfgiFJ6C8ScosEfgLEk";
  systems = [
    xeravus
    lutik
    xorus
  ];
  server = [
    lutik
  ];
in {
  "global.age" = {
    publicKeys = users ++ systems;
  };
  "password_cato.age" = {
    publicKeys = users ++ systems;
  };
  "password_root.age" = {
    publicKeys = users ++ systems;
  };
  "matrix.yaml.age" = {
    publicKeys = users ++ server;
  };
  "mautrix_disord.env.age" = {
    publicKeys = users ++ server;
  };
  "mautrix_whatsapp.env.age" = {
    publicKeys = users ++ server;
  };
  "netbird.env.age" = {
    publicKeys = users ++ systems;
  };
  "syncthing.age" = {
    publicKeys = users ++ systems;
  };
  "github-runner.age" = {
    publicKeys = users ++ systems;
  };
}
