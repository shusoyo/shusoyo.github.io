{
  description = "ss's personal blog";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    meme = {
      url = "github:reuixiy/hugo-theme-meme";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, meme }: let
    systems = [ "x86_64-linux" "x86_64-darwin" ];

    for-all-system = f: nixpkgs.lib.genAttrs
      systems (system: f nixpkgs.legacyPackages.${system})
    ;
  in {
    packages = for-all-system (pkgs: {
      default = pkgs.stdenvNoCC.mkDerivation {
        name = "blog";
        src = ./.;
        buildPhase = ''
          mkdir -p themes
          ln -s ${meme} themes/meme
          ${pkgs.hugo}/bin/hugo --minify
        '';

        installPhase = ''
          cp -r public $out
        '';

        meta = with pkgs.lib; {
          description = "ss's personal blog";
          platforms = platforms.all;
        };
      };
    });

    devShells = for-all-system (pkgs: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [ hugo fish ];

        shellHook = ''
          echo hello hugo
          mkdir -p themes
          ln -s ${meme} themes/meme
          exec fish
        '';
      };
    });
  };
}
