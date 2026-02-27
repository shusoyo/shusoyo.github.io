{
  description = "ss's blog";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    meme = {
      url = "github:reuixiy/hugo-theme-meme";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, meme }: let
    systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];

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

        meta = {
          description = "ss's blog";
          platforms   = pkgs.lib.platforms.all;
        };
      };
    });

    devShells = for-all-system (pkgs: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [ hugo fish ];

        shellHook = ''
          echo hello hugo
          rm -rf themes
          mkdir -p themes
          ln -s ${meme} themes/meme
          exec fish
        '';
      };
    });
  };
}
