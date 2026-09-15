{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    MagicSetEditor2 = {
      url = "github:twanvl/MagicSetEditor2";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, flake-utils,  MagicSetEditor2, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "MagicSetEditor2";
          version = "2.1.2";
          src = MagicSetEditor2;
          buildInputs = [
            pkgs.boost
            pkgs.wxwidgets_3_3
            pkgs.hunspell
          ];

          nativeBuildInputs = [
            pkgs.cmake
            pkgs.pkg-config
          ];

          installPhase = ''
            mkdir -p $out/bin
            cp ./magicseteditor $out/bin/MagicSetEditor2

            mkdir -p $out/share/icons/hicolor/256x256/apps
            cp ${MagicSetEditor2}/resource/icon/app.ico $out/share/icons/hicolor/256x256/apps/MagicSetEditor2.ico

            cp -r ${MagicSetEditor2}/data $out/share/magicseteditor

            mkdir -p $out/share/applications
            cp ${self}/MagicSetEditor2.desktop $out/share/applications/
          '';
        };
      }
    );
}
