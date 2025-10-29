{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby_3_2
    bundler
    nodejs
    yarn
    sqlite
    libffi
    openssl
    zlib
    readline
    libyaml
    git
  ];

  shellHook = ''
    export GEM_HOME="$PWD/.gems"
    export GEM_PATH="$GEM_HOME"
    export PATH="$GEM_HOME/bin:$PATH"
    export BUNDLE_PATH="$GEM_HOME"
    
    echo "Ruby on Rails development environment loaded!"
    echo "Ruby version: $(ruby --version)"
    echo "Bundler version: $(bundler --version)"
  '';
}