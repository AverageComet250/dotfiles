{ config, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "comet" ];
      MaxAuthTries = 3;
      PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
    };
  };
}
