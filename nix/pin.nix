let 
pinnedPkgs = 
    (builtins.fetchGit {
    # Descriptive name to make the store path easier to identify
    name = "nixos-pin-2023.12.27";
    url = "https://github.com/nixos/nixpkgs/";
    rev = "082379ebde87cee1044df759335d9bbd10e1874e";
    }) ;
in
import pinnedPkgs {
  config = {
    # set an agda https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/agda.section.md#agda-agda
    packageOverrides = pkgs: {
      agsy = (pkgs.agda.override { src = builtins.fetchGit {
    name = "agda-jappie";
    url = "https://github.com/jappeace/agda.git";
    rev = "38d473b126e4919e143e6c587c219c3c2ba83c2c";
      } }).withPackages (p: [ p.standard-library ]);
    };
  };

}
