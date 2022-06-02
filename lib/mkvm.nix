# This function creates a NixOS system based on our VM setup for a
# particular architecture.
name: { nixpkgs, home-manager, system, user, overlays }:

nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    # Apply our overlays. Overlays are keyed by system type so we have
    # to go through and apply our system type. We do this first so
    # the overlays are available globally.
    ({ pkgs, ... }:  { 
      nixpkgs.overlays = overlays;
      environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
    })

    ../hardware/${name}.nix
    ../machines/${name}.nix
    ../users/${user}/nixos.nix
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import ../users/${user}/home-manager.nix;
    }
  ];

  # We expose some extra arguments so that our modules can parameterize
  # better based on these values.
  extraArgs = {
    currentSystemName = name;
    currentSystem = system;
  };
}
