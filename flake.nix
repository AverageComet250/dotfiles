{
  inputs = {
    self.submodules = true;
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations."erzatz" = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ./hw/erzatz.nix
        ./config.nix
        ./neovim.nix
        inputs.hjem.nixosModules.default
      ];
    };
  };
}
