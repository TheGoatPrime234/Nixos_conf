let
  cato = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHc0eOrLgxwDdvrFC9WEtOsh+Sx5AqZUUKxhrQWaPIPE cato.jenisch@gmail.com";
  users = [
    cato
  ];

  xeravus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzkvv1qjg8y//HRhcyEoZ7luoVhBNgqvJ1HIzceAVu1";
  lutik = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFxZS/IOSqNcBYlg1oCDUIzqURCiNoQTmdXXQKcSfMpY";
  systems = [
    xeravus
    lutik
  ];
in {
  "global.age" = {
    publicKeys = users ++ systems;
  };
  "matrix.age" = {
    publicKeys = users ++ systems;
  };
  "github-runner.age" = {
    publicKeys = users ++ systems;
  };
}
