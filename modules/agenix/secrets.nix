let
  cato = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHc0eOrLgxwDdvrFC9WEtOsh+Sx5AqZUUKxhrQWaPIPE cato.jenisch@gmail.com";

  # Übersicht
  users = [
    cato
  ];
  systems = [
  ];
in {
  "global.age" = {
    publicKeys = users ++ systems;
  };
  "github-runner.age" = {
    publicKeys = users ++ systems;
  };
}
