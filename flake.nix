{
  inputs = {
    self.submodules = true;
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations."erzatz" = inputs.nixpkgs.lib.nixosSystem {
     specialArgs = {
        root = ./.;
      };
      modules = [
        ./hw/erzatz.nix
        ./config.nix
        ./niri.nix
        ./ssh.nix
        ./users/comet.nix
        ./neovim.nix
        inputs.hjem.nixosModules.default
        inputs.helium.nixosModules.default
      ];
    };

    nixosConfigurations."chalice" = inputs.nixpkgs.lib.nixosSystem {
     specialArgs = {
        root = ./.;
      };
      modules = [
        ./hw/chalice.nix
        ./config.nix
        ./niri.nix
        ./ssh.nix
        ./users/comet.nix
        ./neovim.nix
        inputs.hjem.nixosModules.default
      ];
    };
  };
}
