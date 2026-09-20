{ pkgs, ... }:
let
  neovimWithCargo = pkgs.symlinkJoin {
    name = "neovim-with-cargo";
    paths = [ pkgs.neovim ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.gcc pkgs.cargo pkgs.rustc pkgs.gnumake ]}
    '';
  };
in
{
  environment.systemPackages = [ neovimWithCargo ];
}
