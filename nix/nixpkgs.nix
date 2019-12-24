{ sources ? import ./sources.nix }:

let
  # compilerVersion = "ghc865";

  overlay = _: nixpkgs: {
    ghcide = (import sources.ghcide-nix {})."ghcide-ghc865";

    haskell = nixpkgs.haskell // {
      packages = nixpkgs.haskell.packages // {
        ghc865 = nixpkgs.haskell.packages.ghc865.extend (self: super: {
          ghcide-starter = self.callCabal2nix "ghcide-starter" ../. {};
          niv = (import sources.niv {}).niv;
        });
      };
    };
  };

in import sources.nixpkgs { overlays = [ overlay ]; }
