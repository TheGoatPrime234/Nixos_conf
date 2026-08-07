{
  perSystem = {pkgs, ...}: {
    devShells = {
      default = pkgs.mkShell {
        packages = with pkgs; [
          alejandra
        ];
      };
      rust = pkgs.mkShell {
        packages = with pkgs; [
          cargo
          rustc
          rust-analyzer
          clippy
          rustfmt
          tokei
        ];
        RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      };
    };
  };
}
