{
  description = "NixOS systems and tools for orpheus";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";

    # We use the unstable nixpkgs repo for some packages.
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    rust-overlay.url = "github:oxalica/rust-overlay";
    

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Other packages
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # zig.url = "github:arqv/zig-overlay";
  };

  outputs = { self, nixpkgs, rust-overlay, home-manager, ... }@inputs: let
    mkVM = import ./lib/mkvm.nix;

    # Overlays is the list of overlays we want to apply from flake inputs.
    overlays = [
      # inputs.neovim-nightly-overlay.overlay
      inputs.rust-overlay.overlay

      (final: prev: {
        # kitty = inputs.nixpkgs.kitty
      })
    ];
  in {
    nixosConfigurations.vm-intel = mkVM "vm-intel" rec {
      inherit nixpkgs home-manager overlays;
      system = "x86_64-linux";
      user   = "orpheus";
    };
  };
}
