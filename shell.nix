{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) haskell;
  haskellPackages = haskell.packages.ghc98;
  inherit (haskellPackages)
    cabal-install
    ghc
    ghcid
    haskell-language-server
    ;
in pkgs.mkShell {
  nativeBuildInputs = [
    (haskell.lib.justStaticExecutables (cabal-install))
    ghc
    ghcid
    (haskell.lib.justStaticExecutables (haskell.lib.dontCheck (pkgs.haskellPackages.callHackage "fourmolu" "0.12.0.0" {})))
    haskell-language-server
    pkgs.pkg-config
    pkgs.zlib.dev
  ];
}
