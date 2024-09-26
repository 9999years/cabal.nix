{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) haskell;
  haskellPackages = haskell.packages.ghc910;
  inherit (haskellPackages)
    cabal-install
    ghc
    ghcid
    haskell-language-server
    ;
in pkgs.mkShell {
  nativeBuildInputs = [
    (haskell.lib.justStaticExecutables cabal-install)
    ghc
    ghcid
    haskell-language-server
    (haskell.lib.justStaticExecutables (haskell.lib.dontCheck (pkgs.haskellPackages.callHackage "fourmolu" "0.12.0.0" {})))
    pkgs.pkg-config
    pkgs.zlib.dev
  ];
}
