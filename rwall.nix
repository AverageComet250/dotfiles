{ writeShellApplication, zsh, coreutils, awww, lutgen, imagemagick, jq, root }:

writeShellApplication {
  name = "rwall";

  runtimeInputs = [
    zsh
    coreutils
    awww
    lutgen
    imagemagick
    jq
  ];

  # TODO: use makeScriptWriter and makeWrapperArgs/"--prefix" "PATH" ":" "${lib.makeBinPath []}"

  text = "zsh ${root}/.local/bin/rwall";
}
