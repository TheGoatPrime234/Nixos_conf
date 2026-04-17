{ config, pkgs, ... }: 

let

  pixie-sddm-theme = pkgs.stdenv.mkDerivation {
    pname = "pixie-sddm";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "xCaptaiN09";
      repo = "pixie-sddm";
      rev = "main"; 
      sha256 = "sha256-lmE/49ySuAZDh5xLochWqfSw9qWrIV+fYaK5T2Ckck8"; 
    };
    installPhase = ''
      mkdir -p $out/share/sddm/themes/pixie
      cp -r ./* $out/share/sddm/themes/pixie/
      echo "QtVersion=6" >> $out/share/sddm/themes/pixie/metadata.desktop
    '';
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "pixie";
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pixie-sddm-theme
    
    kdePackages.qtdeclarative
    kdePackages.qtsvg
    kdePackages.qt5compat
  ];
}
