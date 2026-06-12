{
  config,
  pkgs,
  lib,
  ...
}: let
  secrets = import "/home/cato/xanterella/config/modules/agenix/usb-secrets.nix";
in {
  options = {
    xanterella = {
      network = {
        enable = lib.mkEnableOption "Aktiviert network";
      };
      network-crylia = {
        enable = lib.mkEnableOption "Aktiviert NetworkManger für Crylia";
      };
      network-installer = {
        enable = lib.mkEnableOption "Aktiviert NetworkManager für den Installer mit automatischen Wlan Passwort";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.xanterella.network.enable {
      networking = {
        wireless = {
          enable = false;
        };
        networkmanager = {
          enable = true;
          insertNameservers = [
            "1.1.1.1"
            "1.0.0.1"
            "8.8.8.8"
          ];
        };
      };
    })
    (lib.mkIf config.xanterella.network-crylia.enable {
      networking = {
        wireless = {
          enable = false;
        };
        networkmanager = {
          enable = true;
          insertNameservers = [
            "1.1.1.1"
            "1.0.0.1"
            "8.8.8.8"
          ];
          ensureProfiles = {
            environmentFiles = [
              "/etc/wifi_secrets"
            ];
            profiles = {
              home = {
                connection = {
                  id = "Obi Wlan Kenobi";
                  type = "wifi";
                };
                ipv4 = {
                  method = "auto";
                };
                ipv6 = {
                  method = "auto";
                };
                wifi = {
                  mode = "infrastructure";
                  ssid = "Obi Wlan Kenobi";
                };
                wifi-security = {
                  auth-alg = "open";
                  key-mgmt = "wpa-psk";
                  psk = "$PSK_HOME";
                };
              };
              #hotspot = { connection = { id = "S25+ von Cato"; type = "wifi"; }; ipv4 = { method = "auto"; }; ipv6 = { method = "auto"; }; wifi = { mode = "infrastructure"; ssid = "S25+ von Cato"; }; wifi-security = { auth-alg = "open"; key-mgmt = "wpa-psk"; psk = "$PSK_HOTSPOT$"; }; };
            };
          };
        };
      };
    })
    (lib.mkIf config.xanterella.network-installer.enable {
      networking = {
        wireless = {
          enable = false;
        };
        networkmanager = {
          enable = true;
          ensureProfiles = {
            profiles = {
              "${secrets.wifiSsid}" = {
                connection = {
                  id = secrets.wifiSsid;
                  type = "wifi";
                };
                wifi = {
                  mode = "infrastructure";
                  ssid = secrets.wifiSsid;
                };
                wifi-security = {
                  auth-alg = "open";
                  key-mgmt = "wpa-psk";
                  psk = secrets.wifiPassword;
                };
                ipv4 = {
                  method = "auto";
                };
                ipv6 = {
                  method = "auto";
                };
              };
            };
          };
        };
      };
    })
  ];
}
