{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
    let

    pkgs = import nixpkgs {
  config = {
    currentSystem = "";
    # set an agda https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/agda.section.md#agda-agda
    packageOverrides = pkgs: {
      agsy = pkgs.agda.withPackages (p: [ p.standard-library ]);
    };
  };

};
agdaMode =
pkgs.runCommand "agda-mode" {
  agsy=pkgs.agsy;
} ''
set -xe

export PATH=$PATH:$agsy/bin

MODE=$(agda-mode locate | sed s+/agda2.el++g)

mkdir -p $out/share/emacs/site-lisp/elpa/agda-mode-0.0.1/
cp -R $MODE/* $out/share/emacs/site-lisp/elpa/agda-mode-0.0.1/


'';
    in
    {

    packages.x86_64-linux.default = agdaMode;
    packages.x86_64-linux.agdaMode = agdaMode;
    packages.x86_64-linux.agsy = pkgs.agsy;

  };
}
