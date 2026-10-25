{
  inputs = {
    self.submodules = true;
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium.url = "git+https://tangled.org/poacher.dev/helium-flake";
  };

  outputs = inputs: {
    nixosConfigurations."erzatz" = inputs.nixpkgs.lib.nixosSystem {
     specialArgs = {
        root = ./.; # TODO: use ${self} instead
        inherit (inputs) helium;
      };
      modules = [
        ./hw/erzatz.nix
        ./config.nix
        ./niri.nix
        ./ssh.nix
        ./users/comet.nix
        ./neovim.nix
        inputs.hjem.nixosModules.default
      ];
    };

    nixosConfigurations."chalice" = inputs.nixpkgs.lib.nixosSystem {
     specialArgs = {
        root = ./.;
        inherit (inputs) helium;
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
