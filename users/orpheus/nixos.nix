{ pkgs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  users.users.orpheus = {
    isNormalUser = true;
    home = "/home/orpheus";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
    # password is: hunter23
    # generate a password hash with: mkpasswd -m sha-512
    # todo: look into using "initial password hash"
    hashedPassword = "$6$DZoT8QpqXNIRXAyh$0Q6hEg4A.cEUth333w7Rax6hjsTLOMAosEZsb3a5yJntZUVXAuFwKmKaDDlojso8dcdTXqYjObRvZhDwfHnd60";
    openssh.authorizedKeys.keys = [
       "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINvbwNAps0gi5wVrZ/HSYetaMrQKPo6DFUTrGn0y5A63 orpheus@computerdream.club"
    ];
  };

  nixpkgs.overlays = [];
    
}
