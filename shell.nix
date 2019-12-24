let
  compilerVersion = "ghc865";
  pkgs = import ./nix/nixpkgs.nix {};
  projEnv = pkgs.haskell.packages.${compilerVersion}.ghcide-starter.env;
in
pkgs.haskell.packages.${compilerVersion}.shellFor {
  withHoogle = true;
  packages = self: [ self.ghcide-starter ];
  buildInputs = with pkgs; [
    (haskell.packages.${compilerVersion}.ghcWithPackages (p: [
      p.cabal-install
      p.hlint
      p.stylish-cabal
      p.stylish-haskell
      p.pointfree
      p.pointful
      p.niv
    ]))

    ghcide
  ];

  shellHook = ''
    export NIX_GHC="${projEnv.NIX_GHC}"
    export NIX_GHCPKG="${projEnv.NIX_GHCPKG}"
    export NIX_GHC_DOCDIR="${projEnv.NIX_GHC_DOCDIR}"
    export NIX_GHC_LIBDIR="${projEnv.NIX_GHC_LIBDIR}"
    export LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive
    export LANG=en_US.UTF-8
  '';
}
